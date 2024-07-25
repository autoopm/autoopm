package service

import (
	"encoding/json"
	"errors"
	"fmt"
	"sync"
	"time"

	"github.com/jinzhu/gorm"

	"workflow/workflow-engine/flow"
	"workflow/workflow-engine/model"
	"workflow/workflow-engine/types"

	"workflow/util"
)

// ProcessReceiver 接收页面传递参数
type ProcessReceiver struct {
	UserID       string      `json:"userId"`
	ProcInstID   string      `json:"procInstID"`
	Username     string      `json:"username"`
	Company      string      `json:"company"`
	ProcName     string      `json:"procName"`
	Title        string      `json:"title"`
	DepartmentId string      `json:"departmentId"`
	Department   string      `json:"department"`
	Var          *types.Vars `json:"var"`
}

// 构建一个全局评论 参数有用户ID，评论内容，评论图片，评论时间
type GlobalComment struct {
	ProcInstID int    `json:"procInstId"` // 流程实例ID
	UserID     string `json:"userId"`
	Content    string `json:"content"`
	CreatedAt  string `json:"createdAt"`
}

// ProcessPageReceiver 分页参数
type ProcessPageReceiver struct {
	util.Page
	Departments []string `json:"departments"` // 我分管的部门
	Groups      []string `josn:"groups"`      // 我所属于的用户组或者角色
	UserID      string   `json:"userID"`
	Username    string   `json:"username"`
	Company     string   `json:"company"`
	ProcName    string   `json:"procName"` // 流程名称
	ProcInstID  string   `json:"procInstID"`
	State       int      `json:"state"`      // 流程状态
	Sort        string   `json:"sort"`       // 排序
	StartTime   string   `json:"startTime"`  // 开始时间
	EndTime     string   `json:"endTime"`    // 结束时间
	IsFinished  int      `json:"isFinished"` // 是否是结束
}

// 格式化返回参数
type ProcInsts struct {
	model.ProcInst
	Var            *types.Vars  `json:"var,omitempty"`
	NodeInfos      []*NodeInfos `json:"nodeInfos,omitempty"`
	GlobalComments interface{}  `json:"globalComments,omitempty"`
}

var copyLock sync.Mutex

// GetGlobalComment
func GetGlobalComment() *GlobalComment {
	var p = GlobalComment{}
	return &p
}

// GetDefaultProcessPageReceiver GetDefaultProcessPageReceiver
func GetDefaultProcessPageReceiver() *ProcessPageReceiver {
	var p = ProcessPageReceiver{}
	p.PageIndex = 1
	p.PageSize = 10
	return &p
}

func findAll(pr *ProcessPageReceiver) ([]*model.ProcInst, int, error) {
	var page = util.Page{}
	page.PageRequest(pr.PageIndex, pr.PageSize)
	return model.FindProcInsts(pr.UserID, pr.ProcName, pr.Company, pr.Groups, pr.Departments, pr.Sort, pr.PageIndex, pr.PageSize, pr.Username)
}

// AddGlobalComment 添加全局评论
func AddGlobalComment(procInstID int, userID string, content string) error {
	// 获取流程信息
	procInst, err := model.FindProcInstByID(procInstID)
	if err != nil {
		return err
	}
	if procInst != nil {
		// 根据已有的结构体GlobalComment
		globalComment := &GlobalComment{
			ProcInstID: procInstID,
			UserID:     userID,
			Content:    content,
			CreatedAt:  time.Now().Format("2006-01-02 15:04:05"),
		}
		// 追加到现在的评论中
		var globalCommentSlice []GlobalComment
		if procInst.GlobalComment != "" {
			err = json.Unmarshal([]byte(procInst.GlobalComment), &globalCommentSlice)
			if err != nil {
				return err
			}
			// 追加评论
			globalCommentSlice = append(globalCommentSlice, *globalComment)
		} else {
			globalCommentSlice = append(globalCommentSlice, *globalComment)
		}

		// 转为json格式
		globalCommentStr, err := json.Marshal(globalCommentSlice)
		if err != nil {
			return err
		}
		// 更新流程信息
		data := make(map[string]interface{})
		data["global_comment"] = string(globalCommentStr)
		err = model.UpdateProcInstByID(procInstID, data)
		if err != nil {
			return err
		}
	}
	return nil
}

// GetUserStatus 获取用户审批当前状态
func GetUserApprovalStatus(userID int) (string, error) {
	info, err := model.GetProcInstByStarUserIDAndTime(userID)
	if err != nil {
		return "", err
	}
	var data = make(map[string]interface{})
	data["id"] = info.ID
	data["proc_def_name"] = info.ProcDefName
	data["start_user_id"] = info.StartUserID
	return util.ToJSONStr(data)
}

// FindProcInstByID 根据ID获取流程信息
func FindProcInstByID(id int) (string, error) {
	// 流程信息
	data, err := model.FindProcInstByID(id)
	if err != nil {
		return "", err
	}
	// 新的结构体
	datas := &ProcInsts{}
	err = Var2Json(data, datas)
	if err != nil {
		return "", err
	}
	// 如果全局评论不为空，则转为json格式
	if datas.GlobalComment != "" {
		var globalComment []GlobalComment
		err := json.Unmarshal([]byte(datas.GlobalComment), &globalComment)
		if err != nil {
			return "", err
		}
		// 赋值该map给datas
		datas.GlobalComments = globalComment
	}

	// 节点信息
	nodeInfos, err := GetExecNodeInfosDetailsByProcInstID(id)
	if err != nil {
		return "", err
	}

	var newNodeInfos []*NodeInfos
	for _, v := range nodeInfos {
		newNodeInfos = append(newNodeInfos, v)
		if data.IsFinished && data.State == 4 && v.Type == "starter" {
			newNodeInfos = append(newNodeInfos, &NodeInfos{
				NodeInfo: flow.NodeInfo{
					NodeID:      "0",
					Type:        "approver",
					Aprover:     v.Aprover,
					AproverId:   data.StartUserID,
					AproverType: "start",
				},
				Identitylink: &model.Identitylink{
					State:    3,
					UserID:   data.StartUserID,
					UserName: v.Aprover,
				},
				ClaimTime:  data.EndTime,
				IsFinished: true,
			})
		}
	}
	datas.NodeInfos = newNodeInfos
	//
	return util.ToJSONStr(datas)
}

// FindAllPageAsJSON
func FindAllPageAsJSON(pr *ProcessPageReceiver) (string, error) {
	datas, count, err := findAll(pr)
	if err != nil {
		return "", err
	}
	result, err := AllVar2Json(datas)
	if err != nil {
		return "", err
	}
	return util.ToPageJSON(result, count, pr.PageIndex, pr.PageSize)
}

// FindAllTotal
func FindAllTotal(userId string) int {
	return model.FindProcInstsTotal(userId)
}

// FindMyProcInstByToken 根据token获取流程信息
func FindMyProcInstByToken(token string, receiver *ProcessPageReceiver) (string, error) {
	// 根据 token 获取用户信息
	userinfo, err := GetUserinfoFromRedis(token)
	if err != nil {
		return "", err
	}
	if len(userinfo.Company) == 0 {
		return "", errors.New("保存在redis中的【用户信息 userinfo】字段 company 不能为空")
	}
	if len(userinfo.ID) == 0 {
		return "", errors.New("保存在redis中的【用户信息 userinfo】字段 ID 不能为空")
	}
	receiver.Company = userinfo.Company
	receiver.Departments = userinfo.Departments
	receiver.Groups = userinfo.Roles
	receiver.UserID = userinfo.ID
	// str, _ = util.ToJSONStr(receiver)
	// fmt.Printf("receiver:%s\n", str)
	return FindAllPageAsJSON(receiver)
}

// StartProcessInstanceByToken 启动流程
func StartProcessInstanceByToken(token string, p *ProcessReceiver) (string, error) {
	// 根据 token 获取用户信息
	userinfo, err := GetUserinfoFromRedis(token)
	if err != nil {
		return "", err
	}
	if len(userinfo.Company) == 0 {
		return "", errors.New("保存在redis中的【用户信息 userinfo】字段 company 不能为空")
	}
	if len(userinfo.Username) == 0 {
		return "", errors.New("保存在redis中的【用户信息 userinfo】字段 username 不能为空")
	}
	if len(userinfo.ID) == 0 {
		return "", errors.New("保存在redis中的【用户信息 userinfo】字段 ID 不能为空")
	}
	if len(userinfo.Department) == 0 {
		return "", errors.New("保存在redis中的【用户信息 userinfo】字段 department 不能为空")
	}
	p.Company = userinfo.Company
	p.Department = userinfo.Department
	p.UserID = userinfo.ID
	p.Username = userinfo.Username
	return p.StartProcessInstanceByID(p.Var)
}

// StartProcessInstanceByID 启动流程
func (p *ProcessReceiver) StartProcessInstanceByID(variable *types.Vars) (string, error) {
	// times := time.Now()
	// runtime.GOMAXPROCS(2)
	// 获取流程定义
	node, prodefID, procdefName, err := GetResourceByNameAndCompany(p.ProcName, p.Company)
	if err != nil {
		return "", err
	}
	// fmt.Printf("获取流程定义耗时：%v", time.Since(times))
	//--------以下需要添加事务-----------------
	step := 0 // 0 为开始节点
	tx := model.GetTx()
	// 新建流程实例
	jsonStr, err := json.Marshal(variable)
	if err != nil {
		return "", err
	}
	//
	var procInst = &model.ProcInst{
		ProcDefID:     prodefID,
		ProcDefName:   procdefName,
		Title:         p.Title,
		Department:    p.Department,
		DepartmentId:  p.DepartmentId,
		StartTime:     util.FormatDate(time.Now(), util.YYYY_MM_DD_HH_MM_SS),
		StartUserID:   p.UserID,
		StartUserName: p.Username,
		Company:       p.Company,
		Var:           string(jsonStr),
	}
	//开启事务
	// times = time.Now()
	procInstID, err := CreateProcInstTx(procInst, tx) // 事务
	// fmt.Printf("启动流程实例耗时：%v", time.Since(times))
	exec := &model.Execution{
		ProcDefID:  prodefID,
		ProcInstID: procInstID,
	}
	task := &model.Task{
		NodeID:        "0",
		ProcInstID:    procInstID,
		Assignee:      p.UserID,
		IsFinished:    true,
		ClaimTime:     util.FormatDate(time.Now(), util.YYYY_MM_DD_HH_MM_SS),
		Step:          step,
		MemberCount:   1,
		UnCompleteNum: 0,
		ActType:       "or",
		AgreeNum:      1,
	}
	// 生成执行流，一串运行节点
	_, err = GenerateExec(exec, node, p.UserID, p.DepartmentId, variable, tx) //事务
	if err != nil {
		tx.Rollback()
		return "", err
	}
	// 获取执行流信息
	var nodeinfos []*flow.NodeInfo
	err = util.Str2Struct(exec.NodeInfos, &nodeinfos)
	if err != nil {
		tx.Rollback()
		return "", err
	}

	// fmt.Printf("生成执行流耗时：%v", time.Since(times))
	// -----------------生成新任务-------------
	// times = time.Now()
	if nodeinfos[0].ActType == "and" {
		task.UnCompleteNum = nodeinfos[0].MemberCount
		task.MemberCount = nodeinfos[0].MemberCount
	}
	_, err = NewTaskTx(task, tx)
	if err != nil {
		tx.Rollback()
		return "", err
	}
	// fmt.Printf("生成新任务耗时：%v", time.Since(times))
	//--------------------流转------------------
	// times = time.Now()
	// 流程移动到下一环节
	err = MoveStage(nodeinfos, p.UserID, p.Username, p.Company, "", "", task.ID, procInstID, step, true, tx)
	if err != nil {
		tx.Rollback()
		return "", err
	}

	// fmt.Printf("流转到下一流程耗时：%v", time.Since(times))
	// fmt.Println("--------------提交事务----------")
	tx.Commit() //结束事务

	// 查询下一个审批人
	procInst.NodeID = "0"
	for key, v := range nodeinfos {
		if v.Type == "approver" {
			procInst.Candidate = v.AproverId
			procInst.TaskID = task.ID + key
			procInst.NodeID = v.NodeID
			break
		}
	}

	//
	var datas = &ProcInsts{}
	Var2Json(procInst, datas)
	return util.ToJSONStr(datas)
}

// CreateProcInstTx 开户事务
func CreateProcInstTx(procInst *model.ProcInst, tx *gorm.DB) (int, error) {
	return procInst.SaveTx(tx)
}

// SetProcInstFinish SetProcInstFinish
// 设置流程结束
func SetProcInstFinish(procInstID int, endTime string, tx *gorm.DB) error {
	var p = &model.ProcInst{}
	p.ID = procInstID
	p.EndTime = endTime
	p.IsFinished = true
	return p.UpdateTx(tx)
}

// FindAllProcIns 发起的所有流程及节点详情信息
func FindAllProcIns(receiver *ProcessPageReceiver) (string, error) {
	datas, _, err := model.FindAllProcIns(receiver.UserID, receiver.ProcName, receiver.State, receiver.StartTime, receiver.EndTime, receiver.IsFinished, receiver.Username)
	if err != nil {
		return "", err
	}
	result, err := AllVar2Json(datas)
	if err != nil {
		return "", err
	}
	return util.ToJSONStr(result)
}

// StartByMyselfAll 我发起的所有流程
func StartByMyselfAll(receiver *ProcessPageReceiver) (string, error) {
	var page = util.Page{}
	page.PageRequest(receiver.PageIndex, receiver.PageSize)
	datas, count, err := model.StartByMyselfAll(receiver.UserID, receiver.ProcName, receiver.State, receiver.PageIndex, receiver.PageSize, receiver.Username)
	if err != nil {
		return "", err
	}
	result, err := AllVar2Json(datas)
	if err != nil {
		return "", err
	}
	return util.ToPageJSON(result, count, receiver.PageIndex, receiver.PageSize)
}

// StartByMyself 我发起的流程
func StartByMyself(receiver *ProcessPageReceiver) (string, error) {
	var page = util.Page{}
	page.PageRequest(receiver.PageIndex, receiver.PageSize)
	datas, count, err := model.StartByMyself(receiver.UserID, receiver.Company, receiver.PageIndex, receiver.PageSize)
	if err != nil {
		return "", err
	}
	result, err := AllVar2Json(datas)
	if err != nil {
		return "", err
	}
	return util.ToPageJSON(result, count, receiver.PageIndex, receiver.PageSize)
}

// FindProcNotify 查询抄送我的
func FindProcNotify(receiver *ProcessPageReceiver) (string, error) {
	var page = util.Page{}
	page.PageRequest(receiver.PageIndex, receiver.PageSize)
	fmt.Print("receiver.UserID-->" + receiver.UserID)
	datas, count, err := model.FindProcNotify(receiver.UserID, receiver.ProcName, receiver.Company, receiver.Groups, receiver.Sort, receiver.PageIndex, receiver.PageSize)
	if err != nil {
		return "", err
	}
	result, err := AllVar2Json(datas)
	if err != nil {
		return "", err
	}
	return util.ToPageJSON(result, count, receiver.PageIndex, receiver.PageSize)
}

// UpdateProcInst 更新流程实例
func UpdateProcInst(procInst *model.ProcInst, tx *gorm.DB) error {
	return procInst.UpdateTx(tx)
}

// MoveFinishedProcInstToHistory 将已经结束的流程实例移动到历史表
func MoveFinishedProcInstToHistory() error {
	// 要注意并发，可能会运行多个app实例
	// 加锁
	copyLock.Lock()
	defer copyLock.Unlock()
	// 从pro_inst表查询已经结束的流程
	proinsts, err := model.FindFinishedProc()
	if err != nil {
		return err
	}
	if len(proinsts) == 0 {
		return nil
	}
	for _, v := range proinsts {
		// 复制 proc_inst
		duration, err := util.TimeStrSub(v.EndTime, v.StartTime, util.YYYY_MM_DD_HH_MM_SS)
		if err != nil {
			return err
		}
		v.Duration = duration
		err = copyProcToHistory(v)
		if err != nil {
			return err
		}
		tx := model.GetTx()
		// 流程实例的task移至历史纪录
		err = copyTaskToHistoryByProInstID(v.ID, tx)
		if err != nil {
			tx.Rollback()
			DelProcInstHistoryByID(v.ID)
			return err
		}
		// execution移至历史纪录
		err = copyExecutionToHistoryByProcInstID(v.ID, tx)
		if err != nil {
			tx.Rollback()
			DelProcInstHistoryByID(v.ID)
			return err
		}
		// identitylink移至历史纪录
		err = copyIdentitylinkToHistoryByProcInstID(v.ID, tx)
		if err != nil {
			tx.Rollback()
			DelProcInstHistoryByID(v.ID)
			return err
		}
		// 删除流程实例
		err = DelProcInstByIDTx(v.ID, tx)
		if err != nil {
			tx.Rollback()
			DelProcInstHistoryByID(v.ID)
			return err
		}
		tx.Commit()
	}

	return nil
}

// DelProcInstByIDTx 删除流程实例
func DelProcInstByIDTx(procInstID int, tx *gorm.DB) error {
	return model.DelProcInstByIDTx(procInstID, tx)
}

// copyIdentitylinkToHistoryByProcInstID 将identitylink移至历史纪录
func copyIdentitylinkToHistoryByProcInstID(procInstID int, tx *gorm.DB) error {
	return model.CopyIdentitylinkToHistoryByProcInstID(procInstID, tx)
}

// copyExecutionToHistoryByProcInstID 将execution移至历史纪录
func copyExecutionToHistoryByProcInstID(procInstID int, tx *gorm.DB) error {
	return model.CopyExecutionToHistoryByProcInstIDTx(procInstID, tx)
}

// copyProcToHistory 复制 proc_inst
func copyProcToHistory(procInst *model.ProcInst) error {
	return model.SaveProcInstHistory(procInst)

}

// copyTaskToHistoryByProInstID 流程实例的task移至历史纪录
func copyTaskToHistoryByProInstID(procInstID int, tx *gorm.DB) error {
	return model.CopyTaskToHistoryByProInstID(procInstID, tx)
}

// Var 转对象
func Var2Json(p *model.ProcInst, data *ProcInsts) error {
	vars := &types.Vars{}
	// vars-json字符串转对象
	err := util.Str2Struct(p.Var, vars)
	if err != nil {
		return err
	}
	// 复制到新的结构体，并指定排除字段
	err = util.Struct2Struct(p, data, "var")
	if err != nil {
		return err
	}
	//
	data.Var = vars
	//
	return nil
}

// Vars 转对象
func AllVar2Json(datas []*model.ProcInst) ([]*ProcInsts, error) {
	var result []*ProcInsts
	for _, v := range datas {
		dat := &ProcInsts{}
		err := Var2Json(v, dat)
		if err != nil {
			return nil, err
		}
		result = append(result, dat)
	}
	return result, nil
}
