{
  "properties" : { },
  "id" : "55977ef77c294cb3abe54ea2c4333420",
  "script" : null,
  "groupId" : "f2a82a98ff1d49a3904430542a3d776d",
  "name" : "任务工作流信息-已完成",
  "createTime" : 1717060653781,
  "updateTime" : 1713024593421,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/flow",
  "method" : "GET",
  "parameters" : [ {
    "name" : "task_id",
    "value" : "85",
    "description" : "任务ID",
    "required" : true,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "project_id",
    "value" : null,
    "description" : "项目ID - 存在时只返回这个项目的",
    "required" : false,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": [\n        {\n            \"id\": 21,\n            \"project_id\": 7,\n            \"flow_id\": 6,\n            \"name\": \"待处理\",\n            \"status\": \"start\",\n            \"turns\": \"[21,22,23,24,25]\",\n            \"userids\": \"[]\",\n            \"usertype\": \"add\",\n            \"userlimit\": 0,\n            \"columnid\": 0,\n            \"sort\": 0,\n            \"created_at\": \"2024-01-11 09:24:43\",\n            \"updated_at\": \"2024-01-11 09:24:43\"\n        },\n        {\n            \"id\": 22,\n            \"project_id\": 7,\n            \"flow_id\": 6,\n            \"name\": \"进行中\",\n            \"status\": \"progress\",\n            \"turns\": \"[21,22,23,24,25]\",\n            \"userids\": \"[]\",\n            \"usertype\": \"add\",\n            \"userlimit\": 0,\n            \"columnid\": 0,\n            \"sort\": 1,\n            \"created_at\": \"2024-01-11 09:24:43\",\n            \"updated_at\": \"2024-01-11 09:24:43\"\n        },\n        {\n            \"id\": 23,\n            \"project_id\": 7,\n            \"flow_id\": 6,\n            \"name\": \"已完成\",\n            \"status\": \"end\",\n            \"turns\": \"[21,22,23,24,25]\",\n            \"userids\": \"[]\",\n            \"usertype\": \"add\",\n            \"userlimit\": 0,\n            \"columnid\": 0,\n            \"sort\": 3,\n            \"created_at\": \"2024-01-11 09:24:43\",\n            \"updated_at\": \"2024-01-11 09:24:43\"\n        },\n        {\n            \"id\": 24,\n            \"project_id\": 7,\n            \"flow_id\": 6,\n            \"name\": \"已取消\",\n            \"status\": \"end\",\n            \"turns\": \"[21,22,23,24,25]\",\n            \"userids\": \"[]\",\n            \"usertype\": \"add\",\n            \"userlimit\": 0,\n            \"columnid\": 0,\n            \"sort\": 4,\n            \"created_at\": \"2024-01-11 09:24:43\",\n            \"updated_at\": \"2024-01-11 09:24:43\"\n        },\n        {\n            \"id\": 25,\n            \"project_id\": 7,\n            \"flow_id\": 6,\n            \"name\": \"待测试\",\n            \"status\": \"test\",\n            \"turns\": \"[21,22,23,24,25]\",\n            \"userids\": \"[]\",\n            \"usertype\": \"add\",\n            \"userlimit\": 0,\n            \"columnid\": 0,\n            \"sort\": 2,\n            \"created_at\": \"2024-01-11 09:24:43\",\n            \"updated_at\": \"2024-01-11 09:24:43\"\n        }\n    ],\n    \"timestamp\": 1706609118845,\n    \"executeTime\": 9\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import org.ssssssss.script.parsing.ast.statement.Return
import log
import 'cn.dev33.satoken.stp.StpUtil';

// var userid = StpUtil.getLoginId()

//添加统计信息
var task = db.table("project_tasks").where().eq("id", task_id).selectOne()
log.info("task is.  " + task)
if (task == null) {
    exit 400, '任务不存在'
}

var projectFlow = db.table("project_flows").where().eq("project_id", task.project_id).selectOne()
log.info("projectFlow is.  " + projectFlow)
if (projectFlow == null) {
    exit 400, '任务工作流不存在'
}

var projectFlowItem =   db.table('project_flow_items').where().eq("project_id", task.project_id).eq("flow_id", projectFlow.id).select()
log.info("projectFlowItem is.  " + projectFlowItem)
if (projectFlowItem == null) {
    exit 400, '任务工作流项不存在'
}

var data = {
    task_id,
    flow_item_id,
    turns
}

data.task_id= task.id
data.flow_item_id = task.flow_item_id
data.turns = projectFlowItem


return data



