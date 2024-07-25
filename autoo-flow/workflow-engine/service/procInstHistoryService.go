package service

import (
	"errors"

	"workflow/workflow-engine/model"
	"workflow/workflow-engine/types"

	"workflow/util"
)

// FindProcHistory 查询我的审批
func FindProcHistory(receiver *ProcessPageReceiver) (string, error) {
	datas, count, err := findAllProcHistory(receiver)
	if err != nil {
		return "", err
	}
	result, err := AllVar2JsonHistory(datas)
	if err != nil {
		return "", err
	}
	return util.ToPageJSON(result, count, receiver.PageIndex, receiver.PageSize)
}

// FindProcHistoryByToken 查询我的审批纪录
func FindProcHistoryByToken(token string, receiver *ProcessPageReceiver) (string, error) {
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
	receiver.UserID = userinfo.ID
	// receiver.Username = userinfo.Username
	return FindProcHistory(receiver)
}
func findAllProcHistory(receiver *ProcessPageReceiver) ([]*model.ProcInstHistory, int, error) {
	var page = util.Page{}
	page.PageRequest(receiver.PageIndex, receiver.PageSize)
	return model.FindProcHistory(receiver.UserID, receiver.ProcName, receiver.Company, receiver.Sort, receiver.PageIndex, receiver.PageSize, receiver.Username)
}

// DelProcInstHistoryByID
func DelProcInstHistoryByID(id int) error {
	return model.DelProcInstHistoryByID(id)
}

// StartHistoryByMyself 查询我发起的流程
func StartHistoryByMyself(receiver *ProcessPageReceiver) (string, error) {
	var page = util.Page{}
	page.PageRequest(receiver.PageIndex, receiver.PageSize)
	datas, count, err := model.StartHistoryByMyself(receiver.UserID, receiver.Company, receiver.PageIndex, receiver.PageSize)
	if err != nil {
		return "", err
	}
	result, err := AllVar2JsonHistory(datas)
	if err != nil {
		return "", err
	}
	return util.ToPageJSON(result, count, receiver.PageIndex, receiver.PageSize)
}

// FindProcHistoryNotify 查询抄送我的流程
func FindProcHistoryNotify(receiver *ProcessPageReceiver) (string, error) {
	var page = util.Page{}
	page.PageRequest(receiver.PageIndex, receiver.PageSize)
	datas, count, err := model.FindProcHistoryNotify(receiver.UserID, receiver.ProcName, receiver.Company, receiver.Groups, receiver.Sort, receiver.PageIndex, receiver.PageSize, receiver.Username)
	if err != nil {
		return "", err
	}
	result, err := AllVar2JsonHistory(datas)
	if err != nil {
		return "", err
	}
	return util.ToPageJSON(result, count, receiver.PageIndex, receiver.PageSize)
}

// Var 转对象
func Var2JsonHistory(p *model.ProcInstHistory, data *ProcInsts) error {
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
func AllVar2JsonHistory(datas []*model.ProcInstHistory) ([]*ProcInsts, error) {
	var result []*ProcInsts
	for _, v := range datas {
		dat := &ProcInsts{}
		err := Var2JsonHistory(v, dat)
		if err != nil {
			return nil, err
		}
		result = append(result, dat)
	}
	return result, nil
}
