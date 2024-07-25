package service

import (
	"errors"
	"fmt"
	"strconv"
	"strings"
	"sync"
	"time"

	"workflow/workflow-engine/flow"

	"github.com/jinzhu/gorm"

	"workflow/workflow-engine/model"

	"workflow/util"
)

// TaskReceiver 任务
type TaskReceiver struct {
	TaskID     int    `json:"taskID"`
	UserID     string `json:"userID,omitempty"`
	UserName   string `json:"username,omitempty"`
	Pass       string `json:"pass,omitempty"`
	Company    string `json:"company,omitempty"`
	ProcInstID int    `json:"procInstID,omitempty"`
	Comment    string `json:"comment,omitempty"`
	Candidate  string `json:"candidate,omitempty"`
}

var completeLock sync.Mutex

// NewTask 新任务
func NewTask(t *model.Task) (int, error) {
	if len(t.NodeID) == 0 {
		return 0, errors.New("request param nodeID can not be null / 任务当前所在节点nodeId不能为空！")
	}
	t.CreateTime = util.FormatDate(time.Now(), util.YYYY_MM_DD_HH_MM_SS)
	return t.NewTask()
}

// NewTaskTx 开启事务
func NewTaskTx(t *model.Task, tx *gorm.DB) (int, error) {
	if len(t.NodeID) == 0 {
		return 0, errors.New("request param nodeID can not be null / 任务当前所在节点nodeId不能为空！")
	}
	t.CreateTime = util.FormatDate(time.Now(), util.YYYY_MM_DD_HH_MM_SS)
	return t.NewTaskTx(tx)
}

// DeleteTask 删除任务
func DeleteTask(id int) error {
	return model.DeleteTask(id)
}

// GetTaskByID 通过id获取任务
func GetTaskByID(id int) (task *model.Task, err error) {
	return model.GetTaskByID(id)
}

// GetTaskByProInstID 通过流程实例id获取任务
func GetTaskByProInstID(procInstID int) ([]*model.Task, error) {
	return model.GetTaskByProInstID(procInstID)
}

// GetTaskLastByProInstID 通过流程实例id获取最后一个任务
func GetTaskLastByProInstID(procInstID int) (*model.Task, error) {
	return model.GetTaskLastByProInstID(procInstID)
}

// CompleteByToken 通过token 审批任务
func CompleteByToken(token string, receiver *TaskReceiver) (*model.Task, error) {
	userinfo, err := GetUserinfoFromRedis(token)
	if err != nil {
		return nil, err
	}
	pass, err := strconv.ParseBool(receiver.Pass)
	if err != nil {
		return nil, err
	}
	var task *model.Task
	task, err = Complete(receiver.TaskID, userinfo.ID, userinfo.Username, userinfo.Company, receiver.Comment, receiver.Candidate, pass)
	if err != nil {
		return nil, err
	}
	return task, nil
}

// Complete 审批
func Complete(taskID int, userID, username, company, comment, candidate string, pass bool) (*model.Task, error) {
	tx := model.GetTx()
	task, err := CompleteTaskTx(taskID, userID, username, company, comment, candidate, pass, tx)
	if err != nil {
		tx.Rollback()
		return nil, err
	}
	tx.Commit()
	return task, nil
}

// UpdateTaskWhenComplete 更新任务
func UpdateTaskWhenComplete(taskID int, userID string, pass bool, tx *gorm.DB) (*model.Task, error) {
	// 获取task
	completeLock.Lock()         // 关锁
	defer completeLock.Unlock() //解锁
	// 查询任务
	task, err := GetTaskByID(taskID)
	if err != nil {
		return nil, err
	}
	if task == nil {
		return nil, errors.New("任务不存在")
	}
	// 判断是否已经结束
	if task.IsFinished == true {
		if task.NodeID == "结束" {
			return nil, errors.New("流程已经结束")
		}
		return nil, errors.New("任务已经被审批过了！！")
	}

	//判断是否对应的审批人
	data, err := model.FindProcInstByID(task.ProcInstID)
	if err != nil {
		return nil, err
	}
	if !util.IsContain(strings.Split(data.Candidate, ","), userID) {
		return nil, errors.New("无权限")
	}

	// 设置处理人和处理时间
	task.Assignee = userID
	task.ClaimTime = util.FormatDate(time.Now(), util.YYYY_MM_DD_HH_MM_SS)
	// ----------------会签 （默认全部通过才结束），只要存在一个不通过，就结束，然后流转到上一步
	//同意
	if pass {
		task.AgreeNum++
	} else {
		task.IsFinished = true
	}
	// 未审批人数减一
	task.UnCompleteNum = task.UnCompleteNum - 1
	// 判断是否结束
	if task.UnCompleteNum == 0 {
		task.IsFinished = true
	}
	err = task.UpdateTx(tx)
	if err != nil {
		return nil, err
	}
	return task, nil
}

// CompleteTaskTx 执行任务
func CompleteTaskTx(taskID int, userID, username, company, comment, candidate string, pass bool, tx *gorm.DB) (*model.Task, error) {

	//更新任务
	task, err := UpdateTaskWhenComplete(taskID, userID, pass, tx)
	if err != nil {
		return nil, err
	}

	// 如果是会签
	if task.ActType == "and" {
		// fmt.Println("------------------是会签，判断用户是否已经审批过了，避免重复审批-------")
		// 判断用户是否已经审批过了（存在会签的情况）
		yes, err := IfParticipantByTaskID(userID, company, taskID)
		if err != nil {
			tx.Rollback()
			return nil, err
		}
		if yes {
			tx.Rollback()
			return nil, errors.New("您已经审批过了，请等待他人审批！）")
		}
	}

	// 查看任务的未审批人数是否为0，不为0就不流转
	if task.UnCompleteNum > 0 && pass == true { // 默认是全部通过
		// 添加参与人
		err := AddParticipantTx(userID, username, company, comment, pass, task.ID, task.ProcInstID, task.Step, tx)
		if err != nil {
			return nil, err
		}
		return nil, nil
	}

	// 流转到下一流程
	err = MoveStageByProcInstID(userID, username, company, comment, candidate, task.ID, task.ProcInstID, task.Step, pass, tx)
	if err != nil {
		return nil, err
	}

	return task, nil
}

// WithDrawTaskByToken 撤回任务
func WithDrawTaskByToken(token string, receiver *TaskReceiver) error {
	userinfo, err := GetUserinfoFromRedis(token)
	if err != nil {
		return err
	}
	if len(userinfo.ID) == 0 {
		return errors.New("保存在redis中的【用户信息 userinfo】字段 ID 不能为空！！")
	}
	if len(userinfo.Username) == 0 {
		return errors.New("保存在redis中的【用户信息 userinfo】字段 username 不能为空！！")
	}
	if len(userinfo.Company) == 0 {
		return errors.New("保存在redis中的【用户信息 userinfo】字段 company 不能为空")
	}
	return WithDrawTask(receiver.TaskID, receiver.ProcInstID, userinfo.ID, userinfo.Username, userinfo.Company, receiver.Comment)
}

// WithDrawTask 撤回任务
func WithDrawTask(taskID, procInstID int, userID, username, company, comment string) error {
	var err1, err2 error
	var currentTask, lastTask *model.Task
	var wg sync.WaitGroup
	// var timesx time.Time
	// timesx = time.Now()
	wg.Add(2)
	go func() {
		currentTask, err1 = GetTaskByID(taskID)
		wg.Done()
	}()
	go func() {
		lastTask, err2 = GetTaskLastByProInstID(procInstID)
		wg.Done()
	}()
	wg.Wait()
	if err1 != nil {
		if err1 == gorm.ErrRecordNotFound {
			return errors.New("任务不存在")
		}
		return err1
	}
	if err2 != nil {
		if err2 == gorm.ErrRecordNotFound {
			return errors.New("找不到流程实例id为【" + fmt.Sprintf("%d", procInstID) + "】的任务，无权撤回")
		}
		return err2
	}
	if currentTask.Step == 0 {
		return errors.New("开始位置无法撤回")
	}
	if currentTask.IsFinished {
		return errors.New("已经审批结束，无法撤回！")
	}
	if lastTask.Assignee != userID {
		return errors.New("只能撤回本人审批过的任务！！")
		// return errors.New("只能撤回本人审批过的任务！！")
	}
	if currentTask.UnCompleteNum != currentTask.MemberCount {
		return errors.New("已经有人审批过了，无法撤回！")
	}
	sub := currentTask.Step - lastTask.Step
	// if math.Abs(float64(sub)) != 1 {
	// return errors.New("只能撤回相邻的任务！")
	// }
	var pass = false
	if sub < 0 {
		pass = true
	}
	// fmt.Printf("判断是否可以撤回,耗时：%v\n", time.Since(timesx))
	// timesx = time.Now()
	tx := model.GetTx()
	// 更新当前的任务
	currentTask.IsFinished = true
	err := currentTask.UpdateTx(tx)
	if err != nil {
		tx.Rollback()
		return err
	}
	// 撤回
	err = MoveStageByProcInstID(userID, username, company, comment, "", currentTask.ID, procInstID, currentTask.Step, pass, tx, 3)
	if err != nil {
		tx.Rollback()
		return err
	}
	// 更新状态
	var procInst = &model.ProcInst{State: 4}
	procInst.ID = procInstID
	err = UpdateProcInst(procInst, tx)
	if err != nil {
		tx.Rollback()
		return err
	}
	//
	tx.Commit()
	// fmt.Printf("撤回流程耗时：%v\n", time.Since(timesx))
	return nil
}

// MoveStageByProcInstID 根据流程实例id流转流程
func MoveStageByProcInstID(userID, username, company, comment, candidate string, taskID, procInstID, step int, pass bool, tx *gorm.DB, state ...int) (err error) {
	nodeInfos, err := GetExecNodeInfosByProcInstID(procInstID)
	if err != nil {
		return err
	}
	var t int
	if state != nil {
		t = state[0]
	}
	return MoveStage(nodeInfos, userID, username, company, comment, candidate, taskID, procInstID, step, pass, tx, t)
}

// MoveStage 流程流转
func MoveStage(nodeInfos []*flow.NodeInfo, userID, username, company, comment, candidate string, taskID, procInstID, step int, pass bool, tx *gorm.DB, state ...int) (err error) {
	var t int
	if state != nil {
		t = state[0]
	}
	// 添加上一步的参与人
	err = AddParticipantTx(userID, username, company, comment, pass, taskID, procInstID, step, tx, t)
	if err != nil {
		return err
	}
	if pass {
		step++
		if step-1 > len(nodeInfos) {
			return errors.New("已经结束无法流转到下一个节点")
		}
	} else {
		step--
		if step < 0 {
			return errors.New("处于开始位置，无法回退到上一个节点")
		}
	}

	// 指定下一步执行人
	// if len(candidate) > 0 {
	// nodeInfos[step].Aprover = candidate
	// }

	// 判断下一流程： 如果是审批人是：抄送人
	if nodeInfos[step].AproverType == flow.NodeTypes[flow.NOTIFIER] {
		// 生成新的任务
		var task = model.Task{
			NodeID:     nodeInfos[step].NodeID,
			Step:       step,
			ProcInstID: procInstID,
			IsFinished: true,
		}
		task.IsFinished = true
		_, err := task.NewTaskTx(tx)
		if err != nil {
			return err
		}
		// 添加抄送人
		err = AddNotifierTx(task.ID, nodeInfos[step].Aprover, company, step, procInstID, tx, nodeInfos[step].NodeUserList)
		if err != nil {
			return err
		}
		return MoveStage(nodeInfos, userID, username, company, comment, candidate, task.ID, procInstID, step, pass, tx)
	}

	//  判断下一流程： 如果审批人是自己，自动通过
	var startUserID string
	data, err := model.FindProcInstByID(procInstID)
	if err == nil {
		startUserID = data.StartUserID
	} else {
		startUserID = userID
	}
	if nodeInfos[step].AproverId == startUserID {
		// 生成新的任务
		var task = model.Task{
			NodeID:     nodeInfos[step].NodeID,
			Step:       step,
			ProcInstID: procInstID,
			IsFinished: true,
		}
		task.IsFinished = true
		_, err := task.NewTaskTx(tx)
		if err != nil {
			return err
		}
		// 通过
		err = MoveToNextStage(nodeInfos, userID, company, taskID, procInstID, step, comment, tx)
		if err != nil {
			return err
		}
		//
		return MoveStage(nodeInfos, userID, username, company, "自动通过,审批人与发起人为同一人", candidate, task.ID, procInstID, step, pass, tx)
	}

	// 通过
	if pass {
		return MoveToNextStage(nodeInfos, userID, company, taskID, procInstID, step, comment, tx)
	}

	// 驳回
	return MoveToPrevStage(nodeInfos, userID, company, taskID, procInstID, step, comment, tx)
}

// MoveToNextStage 通过
func MoveToNextStage(nodeInfos []*flow.NodeInfo, userID, company string, currentTaskID, procInstID, step int, comment string, tx *gorm.DB) error {
	var currentTime = util.FormatDate(time.Now(), util.YYYY_MM_DD_HH_MM_SS)
	var task = getNewTask(nodeInfos, step, procInstID, currentTime) //新任务
	var procInst = &model.ProcInst{                                 // 流程实例要更新的字段
		NodeID:    nodeInfos[step].NodeID,
		Candidate: nodeInfos[step].AproverId,
	}
	procInst.ID = procInstID
	if (step + 1) != len(nodeInfos) { // 下一步不是【结束】
		// 生成新的任务
		taksID, err := task.NewTaskTx(tx)
		if err != nil {
			return err
		}
		// 添加candidate group
		err = AddCandidateGroupTx(nodeInfos[step].Aprover, company, step, taksID, procInstID, tx)
		if err != nil {
			return err
		}
		// 更新流程实例
		procInst.TaskID = taksID
		procInst.State = 1
		procInst.LatestComment = comment
		err = UpdateProcInst(procInst, tx)
		if err != nil {
			return err
		}
	} else { // 最后一步直接结束
		// 生成新的任务
		task.IsFinished = true
		task.ClaimTime = currentTime
		taksID, err := task.NewTaskTx(tx)
		if err != nil {
			return err
		}
		// 删除候选用户组
		err = DelCandidateByProcInstID(procInstID, tx)
		if err != nil {
			return err
		}
		// 更新流程实例
		procInst.TaskID = taksID
		procInst.EndTime = currentTime
		procInst.IsFinished = true
		procInst.Candidate = "审批结束"
		procInst.State = 2
		procInst.LatestComment = comment
		err = UpdateProcInst(procInst, tx)
		if err != nil {
			return err
		}
	}
	return nil
}

// MoveToPrevStage 驳回
func MoveToPrevStage(nodeInfos []*flow.NodeInfo, userID, company string, currentTaskID, procInstID, step int, comment string, tx *gorm.DB) error {
	// 生成新的任务
	var currentTime = util.FormatDate(time.Now(), util.YYYY_MM_DD_HH_MM_SS)
	// var task = getNewTask(nodeInfos, step, procInstID, currentTime) //新任务
	// task.IsFinished = true
	// task.ClaimTime = currentTime
	// task.ClaimTime = currentTime
	// taksID, err := task.NewTaskTx(tx)
	// if err != nil {
	// 	return err
	// }
	// 删除候选用户组
	err := DelCandidateByProcInstID(procInstID, tx)
	if err != nil {
		return err
	}
	// 流程实例要更新的字段
	var procInst = &model.ProcInst{
		// NodeID:     nodeInfos[step].NodeID,
		// TaskID:     taksID,
		Candidate:     nodeInfos[step].AproverId,
		EndTime:       currentTime,
		IsFinished:    true,
		LatestComment: comment,
		State:         3,
	}

	procInst.ID = procInstID
	err = UpdateProcInst(procInst, tx)
	if err != nil {
		return err
	}
	// 流程回到起始位置，注意起始位置为0,
	// if step == 0 {
	// 	err = AddCandidateUserTx(nodeInfos[step].Aprover, company, step, taksID, procInstID, tx)
	// 	if err != nil {
	// 		return err
	// 	}
	// 	return nil
	// }
	// 添加candidate group
	// err = AddCandidateGroupTx(nodeInfos[step].Aprover, company, step, taksID, procInstID, tx)
	// if err != nil {
	// 	return err
	// }
	return nil
}
func getNewTask(nodeInfos []*flow.NodeInfo, step, procInstID int, currentTime string) *model.Task {
	var task = &model.Task{ // 新任务
		NodeID:        nodeInfos[step].NodeID,
		Step:          step,
		CreateTime:    currentTime,
		ProcInstID:    procInstID,
		MemberCount:   nodeInfos[step].MemberCount,
		UnCompleteNum: nodeInfos[step].MemberCount,
		ActType:       nodeInfos[step].ActType,
	}
	return task
}
