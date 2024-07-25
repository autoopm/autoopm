package service

import (
	"strings"
	"workflow/workflow-engine/flow"
	"workflow/workflow-engine/model"

	"workflow/util"

	"github.com/jinzhu/gorm"
)

// SaveIdentitylinkTx 保存Identitylink
func SaveIdentitylinkTx(i *model.Identitylink, tx *gorm.DB) error {
	return i.SaveTx(tx)
}

// AddNotifierTx 添加抄送人候选用户组
func AddNotifierTx(taskID int, group, company string, step, procInstID int, tx *gorm.DB, nodeUserList []*flow.NodeUser) error {
	yes, err := ExistsNotifierByProcInstIDAndGroup(procInstID, group)
	if err != nil {
		return err
	}
	if yes {
		return nil
	}

	ids := make([]string, len(nodeUserList))
	names := make([]string, len(nodeUserList))
	for i := range nodeUserList {
		ids[i] = nodeUserList[i].TargetId
		names[i] = nodeUserList[i].Name
	}

	d := &model.Identitylink{
		Group:      group,
		Type:       model.IdentityTypes[model.NOTIFIER],
		Step:       step,
		ProcInstID: procInstID,
		Company:    company,
		State:      1,
		TaskID:     taskID,
		UserID:     strings.Join(ids, ","),
		UserName:   strings.Join(names, ","),
	}
	return SaveIdentitylinkTx(d, tx)
}

// AddCandidateGroupTx 添加候选用户组
func AddCandidateGroupTx(group, company string, step, taskID, procInstID int, tx *gorm.DB) error {
	err := DelCandidateByProcInstID(procInstID, tx)
	if err != nil {
		return err
	}
	i := &model.Identitylink{
		Group:      group,
		Type:       model.IdentityTypes[model.CANDIDATE],
		TaskID:     taskID,
		Step:       step,
		ProcInstID: procInstID,
		Company:    company,
	}
	return SaveIdentitylinkTx(i, tx)
}

// AddCandidateUserTx 添加候选用户
func AddCandidateUserTx(userID, company string, step, taskID, procInstID int, tx *gorm.DB) error {
	err := DelCandidateByProcInstID(procInstID, tx)
	if err != nil {
		return err
	}
	i := &model.Identitylink{
		UserID:     userID,
		Type:       model.IdentityTypes[model.CANDIDATE],
		TaskID:     taskID,
		Step:       step,
		ProcInstID: procInstID,
		Company:    company,
	}
	return SaveIdentitylinkTx(i, tx)
	// var wg sync.WaitGroup
	// var err1, err2 error
	// numberOfRoutine := 2
	// wg.Add(numberOfRoutine)
	// go func() {
	// 	defer wg.Done()
	// 	err1 = DelCandidateByProcInstID(procInstID, tx)
	// }()
	// go func() {
	// 	defer wg.Done()
	// 	i := &model.Identitylink{
	// 		UserID:     userID,
	// 		Type:       model.IdentityTypes[model.CANDIDATE],
	// 		TaskID:     taskID,
	// 		Step:       step,
	// 		ProcInstID: procInstID,
	// 		Company:    company,
	// 	}
	// 	err2 = SaveIdentitylinkTx(i, tx)
	// }()
	// wg.Wait()
	// fmt.Println("保存identyilink结束")
	// if err1 != nil {
	// 	return err1
	// }
	// return err2
}

// AddParticipantTx 添加任务参与人
func AddParticipantTx(userID, username, company, comment string, pass bool, taskID, procInstID, step int, tx *gorm.DB, states ...int) error {
	var state int
	if step == 0 {
		state = 1
	} else {
		if states != nil && states[0] != 0 {
			state = states[0]
		} else if pass {
			state = 1
		} else {
			state = 2
		}
	}
	i := &model.Identitylink{
		Type:       model.IdentityTypes[model.PARTICIPANT],
		UserID:     userID,
		UserName:   username,
		ProcInstID: procInstID,
		Step:       step,
		Company:    company,
		TaskID:     taskID,
		Comment:    comment,
		State:      state,
	}
	return SaveIdentitylinkTx(i, tx)
}

// IfParticipantByTaskID 针对指定任务判断用户是否已经审批过了
func IfParticipantByTaskID(userID, company string, taskID int) (bool, error) {
	return model.IfParticipantByTaskID(userID, company, taskID)
}

// DelCandidateByProcInstID 删除历史候选人
func DelCandidateByProcInstID(procInstID int, tx *gorm.DB) error {
	return model.DelCandidateByProcInstID(procInstID, tx)
}

// ExistsNotifierByProcInstIDAndGroup 抄送人是否已经存在
func ExistsNotifierByProcInstIDAndGroup(procInstID int, group string) (bool, error) {
	return model.ExistsNotifierByProcInstIDAndGroup(procInstID, group)
}

// FindParticipantByProcInstID 查询参与审批的人
func FindParticipantByProcInstID(procInstID int) (string, error) {
	datas, err := model.FindParticipantByProcInstID(procInstID)
	if err != nil {
		return "", err
	}
	str, err := util.ToJSONStr(datas)
	if err != nil {
		return "", err
	}
	return str, nil
}

// FindParticipantAllByProcInstID 查询参与审批的人
func FindParticipantAllByProcInstID(procInstID int) (string, error) {
	datas, err := model.FindParticipantAllByProcInstID(procInstID)
	if err != nil {
		return "", err
	}
	str, err := util.ToJSONStr(datas)
	if err != nil {
		return "", err
	}
	return str, nil
}
