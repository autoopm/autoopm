package controller

import (
	"fmt"
	"net/http"
	"strconv"
	"strings"

	"workflow/workflow-engine/model"
	"workflow/workflow-engine/types"

	"workflow/util"

	"workflow/workflow-engine/service"
)

// StartProcessInstanceByToken 启动流程
func StartProcessInstanceByToken(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "POST" {
		util.ResponseErr(writer, "只支持Post方法！！Only suppoert Post ")
		return
	}
	token := request.Header.Get("Authorization")
	if len(token) == 0 {
		request.ParseForm()
		if len(request.Form["token"]) == 0 {
			util.ResponseErr(writer, "header Authorization 没有保存 token, url参数也不存在 token， 访问失败 ！")
			return
		}
		token = request.Form["token"][0]
	}
	var proc = service.ProcessReceiver{}
	err := util.Body2Struct(request, &proc)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	if len(proc.ProcName) == 0 {
		util.Response(writer, "流程定义名procName不能为空", false)
		return
	}
	id, err := service.StartProcessInstanceByToken(token, &proc)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	util.Response(writer, fmt.Sprintf("%d", id), true)
}

// StartProcessInstance 启动流程
func StartProcessInstance(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "POST" {
		util.ResponseErr(writer, "只支持Post方法！！Only suppoert Post ")
		return
	}
	if model.RedisOpen {
		util.ResponseErr(writer, "已经连接 redis，请使用/workflow/process/startByToken 路径访问")
		return
	}
	var proc = service.ProcessReceiver{}
	err := util.Body2Struct(request, &proc)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}

	if len(proc.ProcName) == 0 {
		util.Response(writer, "流程定义名procName不能为空", false)
		return
	}
	if len(proc.UserID) == 0 {
		util.Response(writer, "启动流程的用户userId不能为空", false)
		return
	}

	// 用户信息
	userInfo, errs := model.GetUserInfoById(proc.UserID)
	if errs != nil {
		util.Response(writer, "用户不存在", false)
		return
	}
	if userInfo.Name != "" {
		proc.Username = userInfo.Name
	} else {
		proc.Username = userInfo.Username
	}

	// 公司
	proc.Company = "系统默认"

	// 部门
	if proc.DepartmentId != "" {
		//TODO 这里不存在了
		//if proc.DepartmentId == 0 {
		//	util.Response(writer, "用户所在部门departmentId不能为空", false)
		//	return
		//}
		//if !strings.Contains(userInfo.Department, ","+strconv.Itoa(proc.DepartmentId)+",") {
		//	util.Response(writer, "部门不存在", false)
		//	return
		//}

		deptInfo, errs := model.GetDeptByID(proc.DepartmentId)
		if errs != nil {
			util.Response(writer, "部门不存在", false)
			return
		}
		proc.Department = deptInfo.Name
	} else {
		proc.Department = "默认部门"
	}

	// 检测var
	if !strings.Contains(proc.ProcName, "请假") {
		is, err := types.CheckOvertimeVars(proc.Var)
		if !is {
			util.Response(writer, fmt.Sprintf("%s", err), false)
			return
		}
	} else {
		is, err := types.CheckVacateVars(proc.Var)
		if !is {
			util.Response(writer, fmt.Sprintf("%s", err), false)
			return
		}
	}

	datas, err := proc.StartProcessInstanceByID(proc.Var)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}

	util.ResponseData(writer, datas)
}

// FindMyProcInstPageAsJSON 查询到我审批的流程实例
func FindMyProcInstPageAsJSON(writer http.ResponseWriter, request *http.Request) {
	if model.RedisOpen {
		util.ResponseErr(writer, "已经连接 redis，请使用/workflow/process/findTaskByToken 路径访问")
		return
	}
	if request.Method != "POST" {
		util.ResponseErr(writer, "只支持Post方法！！Only suppoert Post ")
		return
	}
	var receiver = service.GetDefaultProcessPageReceiver()
	err := util.Body2Struct(request, &receiver)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	if len(receiver.UserID) == 0 {
		util.Response(writer, "用户userID不能为空", false)
		return
	}
	if len(receiver.Company) == 0 {
		receiver.Company = "系统默认"
		// util.Response(writer, "字段 company 不能为空", false)
		// return
	}
	result, err := service.FindAllPageAsJSON(receiver)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}

	util.ResponseData(writer, result)
}

// FindMyProcInstPageAsJSON 查询到我审批的流程实例 - 总数
func FindMyProcInstTotal(writer http.ResponseWriter, request *http.Request) {
	if model.RedisOpen {
		util.ResponseErr(writer, "已经连接 redis，请使用/workflow/process/findTaskByToken 路径访问")
		return
	}
	if request.Method != "GET" {
		util.ResponseErr(writer, "只支持GET方法！！Only suppoert Get ")
		return
	}
	userId := request.URL.Query().Get("userid")
	if len(userId) == 0 {
		util.Response(writer, "用户userID不能为空", false)
		return
	}
	result := map[string]interface{}{
		"total": service.FindAllTotal(userId),
	}
	util.ResponseData(writer, util.StructToJson(result))
}

// FindMyProcInstByToken 查询待办的流程
func FindMyProcInstByToken(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "POST" {
		util.ResponseErr(writer, "只支持Post方法！！")
		return
	}
	token := request.Header.Get("Authorization")
	if len(token) == 0 {
		request.ParseForm()
		if len(request.Form["token"]) == 0 {
			util.ResponseErr(writer, "header Authorization 没有保存 token, url参数也不存在 token， 访问失败 ！")
			return
		}
		token = request.Form["token"][0]
	}
	// fmt.Printf("token:%s\n", token)
	var receiver = service.GetDefaultProcessPageReceiver()
	err := util.Body2Struct(request, &receiver)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	result, err := service.FindMyProcInstByToken(token, receiver)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}

	util.ResponseData(writer, result)
}

// StartByMyselfAll 我启动的所有流程
func StartByMyselfAll(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "POST" {
		util.ResponseErr(writer, "只支持Post方法！！Only suppoert Post ")
		return
	}
	var receiver = service.GetDefaultProcessPageReceiver()
	err := util.Body2Struct(request, &receiver)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	if len(receiver.UserID) == 0 {
		util.Response(writer, "用户userID不能为空", false)
		return
	}
	result, err := service.StartByMyselfAll(receiver)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	util.ResponseData(writer, result)
}

// StartByMyself 我启动的流程
func StartByMyself(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "POST" {
		util.ResponseErr(writer, "只支持Post方法！！Only suppoert Post ")
		return
	}
	var receiver = service.GetDefaultProcessPageReceiver()
	err := util.Body2Struct(request, &receiver)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	if len(receiver.UserID) == 0 {
		util.Response(writer, "用户userID不能为空", false)
		return
	}
	if len(receiver.Company) == 0 {
		receiver.Company = "系统默认"
		// util.Response(writer, "字段 company 不能为空", false)
		// return
	}
	result, err := service.StartByMyself(receiver)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}

	util.ResponseData(writer, result)
}

// FindProcNotify 查询抄送我的流程
func FindProcNotify(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "POST" {
		util.ResponseErr(writer, "只支持POST方法")
	}
	var receiver = service.GetDefaultProcessPageReceiver()
	err := util.Body2Struct(request, &receiver)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	if len(receiver.UserID) == 0 {
		util.Response(writer, "用户userID不能为空", false)
		return
	}
	if len(receiver.Company) == 0 {
		receiver.Company = "系统默认"
		// util.Response(writer, "字段 company 不能为空", false)
		// return
	}
	result, err := service.FindProcNotify(receiver)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}

	util.ResponseData(writer, result)
}

// MoveFinishedProcInstToHistory 将已经结束的流程实例移动到历史数据库
func MoveFinishedProcInstToHistory(writer http.ResponseWriter, request *http.Request) {
	err := service.MoveFinishedProcInstToHistory()
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	util.ResponseOk(writer)
}

// FindProcInstByID 根据流程ID查询流程
func FindProcInstByID(writer http.ResponseWriter, request *http.Request) {
	request.ParseForm()
	if len(request.Form["id"]) == 0 || request.Form["id"][0] == "" {
		util.ResponseErr(writer, "字段 id 不能为空")
		return
	}
	id, err := strconv.Atoi(request.Form["id"][0])
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	data, err := service.FindProcInstByID(id)
	if err != nil {
		util.ResponseData(writer, "{}")
		return
	}
	util.ResponseData(writer, data)
}

// FindAllProcIns 查询所有流程
func FindAllProcIns(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "POST" {
		util.ResponseErr(writer, "只支持Post方法！！")
		return
	}
	var receiver = service.GetDefaultProcessPageReceiver()
	err := util.Body2Struct(request, &receiver)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	result, err := service.FindAllProcIns(receiver)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}

	util.ResponseData(writer, result)
}

// AddGlobalComment 添加全局评论
func AddGlobalComment(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "POST" {
		util.ResponseErr(writer, "只支持Post方法！！")
		return
	}
	//
	var receiver = service.GetGlobalComment()
	err := util.Body2Struct(request, &receiver)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}

	procInstId := receiver.ProcInstID
	// 判断procInstId是否为空
	if procInstId == 0 {
		util.ResponseErr(writer, "procInstId不能为空")
		return
	}
	UserID := receiver.UserID
	Content := receiver.Content
	err = service.AddGlobalComment(procInstId, UserID, Content)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	util.ResponseOk(writer)
}

// GetUserApprovalStatus 获取用户审批当前状态
func GetUserApprovalStatus(writer http.ResponseWriter, request *http.Request) {
	request.ParseForm()
	if len(request.Form["userid"]) == 0 || request.Form["userid"][0] == "" {
		util.ResponseErr(writer, "用户userID不能为空")
		return
	}
	userid, err := strconv.Atoi(request.Form["userid"][0])
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	result, err := service.GetUserApprovalStatus(userid)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}

	util.ResponseData(writer, result)
}
