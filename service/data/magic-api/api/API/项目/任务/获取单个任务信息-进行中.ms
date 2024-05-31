{
  "properties" : { },
  "id" : "7f04e97c9f274a869bb0dc974260c359",
  "script" : null,
  "groupId" : "f2a82a98ff1d49a3904430542a3d776d",
  "name" : "获取单个任务信息-进行中",
  "createTime" : 1717060653870,
  "updateTime" : 1713024594560,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/one",
  "method" : "GET",
  "parameters" : [ {
    "name" : "task_id",
    "value" : "173",
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
    "name" : "archived",
    "value" : null,
    "description" : "归档状态  all：所有 yes：已归档 no：未归档（默认）",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "no",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"id\": 173,\n        \"parent_id\": 0,\n        \"project_id\": 98,\n        \"column_id\": 216,\n        \"dialog_id\": 0,\n        \"flow_item_id\": 227,\n        \"flow_item_name\": \"start|待处理\",\n        \"name\": \"123\",\n        \"color\": \"\",\n        \"desc\": \"\",\n        \"start_at\": 1708304400000,\n        \"end_at\": 1708423200000,\n        \"archived_at\": null,\n        \"archived_userid\": 0,\n        \"archived_follow\": 0,\n        \"complete_at\": null,\n        \"userid\": 1,\n        \"visibility\": 1,\n        \"p_level\": 1,\n        \"p_name\": \"重要且紧急\",\n        \"p_color\": \"#ED4014\",\n        \"sort\": 0,\n        \"loop\": \"\",\n        \"loop_at\": null,\n        \"created_at\": null,\n        \"updated_at\": null,\n        \"deleted_at\": null,\n        \"deleted_userid\": 0,\n        \"taskUser\": [\n            {\n                \"id\": 169,\n                \"project_id\": 98,\n                \"task_id\": 173,\n                \"task_pid\": 173,\n                \"userid\": 1,\n                \"owner\": 1,\n                \"created_at\": 1708311999000,\n                \"updated_at\": null\n            },\n            {\n                \"id\": 170,\n                \"project_id\": 98,\n                \"task_id\": 173,\n                \"task_pid\": 173,\n                \"userid\": 1,\n                \"owner\": 1,\n                \"created_at\": 1708311999000,\n                \"updated_at\": null\n            }\n        ],\n        \"taskTag\": [],\n        \"project_name\": \"测试\",\n        \"column_name\": \"Default\"\n    },\n    \"timestamp\": 1708313748899,\n    \"executeTime\": 28\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : {
    "name" : "",
    "value" : "",
    "description" : "",
    "required" : false,
    "dataType" : "Object",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "",
    "error" : "",
    "expression" : "",
    "children" : [ {
      "name" : "code",
      "value" : "500",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "message",
      "value" : "系统内部出现错误",
      "description" : "",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "data",
      "value" : "null",
      "description" : "",
      "required" : false,
      "dataType" : "Object",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "timestamp",
      "value" : "1708313636471",
      "description" : "",
      "required" : false,
      "dataType" : "Long",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "executeTime",
      "value" : "10",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    } ]
  }
}
================================
//todo 判断项目是否可用 已删除状态先不考虑
//arch  yes  no all：所有

var arch = archived
var builder = db.table("project_tasks").where().eq("id", task_id)

var task

if (arch == 'all') { //获取所有
    task = builder.selectOne() //TODO 针对不同类型返回报错
} else if (arch == 'yes') { //获取已归档
    task = builder.notNull("archived_at").selectOne() //TODO 针对不同类型返回报错
} else { //获取未归档 
    task = builder.isNull("archived_at").selectOne() //TODO 针对不同类型返回报错
}
if (task == null) {
    exit 400, '任务不存在';
}

taskUsers = db.table("project_task_users").where().eq("project_id", task.project_id).eq("task_id", task.id).orderBy('id').select()

var useProject = db.table("projects").where().eq("id", task.project_id).selectOne()
var column = db.table("project_columns").where().eq("id", task.column_id).selectOne()

taskTag = []

//获取统计信息
// task.push({
//     taskUser: taskUsers,
//     taskTag: taskTag,
//     project_name: useProject.name,
//     column_name: column.name,
// })
task.taskUser = taskUsers
task.taskTag = taskTag
task.project_name = useProject.name
task.column_name = column.name

return task