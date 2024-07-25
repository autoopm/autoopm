package controller

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"

	"workflow/workflow-engine/flow"
	"workflow/workflow-engine/service"

	"workflow/util"
)

// SaveProcdefByToken 保存流程定义
func SaveProcdefByToken(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "POST" {
		util.ResponseErr(writer, "只支持Post方法！！Only support Post ")
		return
	}
	token, err := GetToken(request)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	var procdef = service.Procdef{}
	err = util.Body2Struct(request, &procdef)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	if len(procdef.Name) == 0 {
		util.ResponseErr(writer, "流程名称 name 不能为空")
		return
	}
	if procdef.Resource == nil || len(procdef.Resource.Name) == 0 {
		util.ResponseErr(writer, "字段 resource 不能为空")
		return
	}
	id, err := procdef.SaveProcdefByToken(token)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	util.Response(writer, fmt.Sprintf("%d", id), true)
}

// SaveProcdef 保存流程定义
func SaveProcdef(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "POST" {
		util.ResponseErr(writer, "只支持Post方法！！Only support Post ")
		return
	}
	var procdef = service.Procdef{}
	err := util.Body2Struct(request, &procdef)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	if len(procdef.Userid) == 0 {
		util.ResponseErr(writer, "字段 userid 不能为空")
		return
	}
	if len(procdef.Company) == 0 {
		util.ResponseErr(writer, "字段 company 不能为空")
		return
	}
	if len(procdef.Name) == 0 {
		util.ResponseErr(writer, "流程名称 name 不能为空")
		return
	}
	if procdef.Resource == nil || len(procdef.Resource.Name) == 0 {
		util.ResponseErr(writer, "字段 resource 不能为空")
		return
	}
	id, err := procdef.SaveProcdef()
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	util.ResponseData(writer, fmt.Sprintf("%d", id))
}

// FindAllProcdefPage 分页查询
func FindAllProcdefPage(writer http.ResponseWriter, request *http.Request) {
	var procdef = service.Procdef{PageIndex: 1, PageSize: 10}
	err := util.Body2Struct(request, &procdef)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	datas, err := procdef.FindAllPageAsJSON()
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	util.ResponseData(writer, datas)
}

// FindByIdProcdef 根据id查询流程详情
func FindByIdProcdef(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "GET" {
		util.ResponseErr(writer, "只支持get方法！！")
		return
	}

	request.ParseForm()
	if len(request.Form["id"]) == 0 {
		util.ResponseErr(writer, "流程ID不能为空")
		return
	}
	Id, err := strconv.Atoi(request.Form["id"][0])
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}

	prodef, err := service.GetProcdefByID(Id)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}

	flowNode := &flow.Node{}
	err = util.Str2Struct(prodef.Resource, flowNode)
	if err != nil {
		util.ResponseErr(writer, "流程不存在")
		return
	}

	datas, err := json.Marshal(&service.Procdefs{
		Id:       prodef.ID,
		Name:     prodef.Name,
		Userid:   prodef.Userid,
		Username: prodef.Username,
		Company:  prodef.Company,
		Resource: flowNode,
	})
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}

	util.ResponseData(writer, fmt.Sprintf("%s", datas))
}

// FindByNameProcdef 根据name查询流程详情
func FindByNameProcdef(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "GET" {
		util.ResponseErr(writer, "只支持get方法！！")
		return
	}
	request.ParseForm()
	if len(request.Form["name"]) == 0 {
		util.ResponseErr(writer, "字段 name 不能为空")
		return
	}
	if len(request.Form["company"]) == 0 {
		util.ResponseErr(writer, "字段 company 不能为空")
		return
	}
	prodef, err := service.GetProcdefLatestByNameAndCompany(request.Form["name"][0], request.Form["company"][0])
	if err != nil {
		util.ResponseErr(writer, fmt.Sprintf("%s", err))
		return
	}
	//
	if prodef == nil {
		util.ResponseData(writer, "{}")
		return
	}
	//
	flowNode := &flow.Node{}
	err = util.Str2Struct(prodef.Resource, flowNode)
	if err != nil {
		util.ResponseErr(writer, "流程不存在")
		return
	}
	datas, err := json.Marshal(&service.Procdefs{
		Id:       prodef.ID,
		Name:     prodef.Name,
		Userid:   prodef.Userid,
		Username: prodef.Username,
		Company:  prodef.Company,
		Resource: flowNode,
	})
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	util.ResponseData(writer, fmt.Sprintf("%s", datas))
}

// DelProcdefByID 根据id删除流程
func DelProcdefByID(writer http.ResponseWriter, request *http.Request) {
	request.ParseForm()
	var ids []string = request.Form["id"]
	if len(ids) == 0 {
		util.ResponseErr(writer, "request param 【id】 is not valid , id 不存在 ")
		return
	}
	id, err := strconv.Atoi(ids[0])
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	err = service.DelProcdefByID(id)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	util.ResponseOk(writer)
}
