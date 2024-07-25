package controller

import (
	"net/http"
	"strconv"

	"workflow/util"
	"workflow/workflow-engine/service"
)

// GetAllDept 所有部门列表
func GetAllDept(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "GET" {
		util.ResponseErr(writer, "只支持get方法！！")
		return
	}
	request.ParseForm()

	//parentId := -1
	//if len(request.Form["parentId"]) > 0 {
	//	parentId, _ = strconv.Atoi(request.Form["parentId"][0])
	//}

	parentId := ""
	parentId = request.Form["parentId"][0]

	result, err := service.GetAllDept(parentId)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	util.ResponseData(writer, result)
}

// GetDeptUserByDept 根据部门单一获取所有用户，包括子部门，树形结构
func GetDeptUserByDept(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "GET" {
		util.ResponseErr(writer, "只支持get方法！！")
		return
	}
	request.ParseForm()
	if len(request.Form["deptID"]) == 0 {
		util.ResponseErr(writer, "部门ID不能为空")
		return
	}
	if len(request.Form["deptName"]) == 0 {
		util.ResponseErr(writer, "部门名称不能为空")
		return
	}
	//var deptID int
	//deptID, _ = strconv.Atoi(request.Form["deptID"][0])
	var deptID string
	deptID = request.Form["deptID"][0]
	deptName := request.Form["deptName"][0]
	result, err := service.GetUsersByDeptTree(deptID, deptName)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	util.ResponseData(writer, result)
}

// GetAllDeptUserByDept 根据部门全部获取所有用户，包括子部门，树形结构
func GetAllDeptUserByDept(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "GET" {
		util.ResponseErr(writer, "只支持get方法！！")
		return
	}
	request.ParseForm()
	//var parentId int
	//parentId, _ = strconv.Atoi(request.Form["parentId"][0])

	var parentId string
	parentId = request.Form["parentId"][0]
	result, err := service.GetUsersByDeptAllTree(parentId)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	util.ResponseData(writer, result)
}

// GetUserByName 根据用户名称获取用户并分页
func GetUserByName(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "GET" {
		util.ResponseErr(writer, "只支持get方法！！")
		return
	}
	request.ParseForm()
	if len(request.Form["searchName"]) == 0 {
		util.ResponseErr(writer, "用户名不能为空")
		return
	}
	userName := request.Form["searchName"][0]
	var page int = 1
	var pageSize int = 10
	var pages []string = request.Form["page"]
	var pageSizes []string = request.Form["pageSize"]
	if len(pages) > 0 {
		page, _ = strconv.Atoi(pages[0])
	}
	if len(pageSizes) > 0 {
		pageSize, _ = strconv.Atoi(pageSizes[0])
	}
	result, err := service.GetUserByName(userName, page, pageSize)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	util.ResponseData(writer, result)
}
