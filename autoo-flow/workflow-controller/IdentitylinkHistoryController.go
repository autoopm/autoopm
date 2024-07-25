package controller

import (
	"net/http"
	"strconv"

	"workflow/workflow-engine/service"

	"workflow/util"
)

// FindParticipantHistoryByProcInstID 历史纪录查询
func FindParticipantHistoryByProcInstID(writer http.ResponseWriter, request *http.Request) {
	if request.Method != "GET" {
		util.ResponseErr(writer, "只支持get方法！！")
		return
	}
	request.ParseForm()
	//调试输出
	if len(request.Form["procInstId"]) == 0 {
		util.ResponseErr(writer, "流程Id不能为空")
		return
	}
	procInstID, err := strconv.Atoi(request.Form["procInstId"][0])
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	result, err := service.FindParticipantHistoryByProcInstID(procInstID)
	if err != nil {
		util.ResponseErr(writer, err)
		return
	}
	util.ResponseData(writer, result)
}
