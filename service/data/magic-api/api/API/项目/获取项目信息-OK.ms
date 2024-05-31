{
  "properties" : { },
  "id" : "50a1ee98162142568ac06ce8f3394b57",
  "script" : null,
  "groupId" : "0c2d9f4051a44b37a9a0f361f4e13b75",
  "name" : "获取项目信息-OK",
  "createTime" : 1717060653758,
  "updateTime" : 1713325105143,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/one",
  "method" : "GET",
  "parameters" : [ {
    "name" : "project_id",
    "value" : "9",
    "description" : "项目id",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : "",
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ {
    "name" : "token",
    "value" : "2b1c974f-bcaf-4fec-b311-364d9bb9848e",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"id\": 9,\n        \"name\": \"修改的名称2\",\n        \"desc\": \"测试\",\n        \"userid\": 1,\n        \"personal\": false,\n        \"user_simple\": \"\",\n        \"dialog_id\": 22,\n        \"archived_at\": null,\n        \"archived_userid\": 0,\n        \"created_at\": \"2024-01-12 09:43:18\",\n        \"updated_at\": \"2024-01-12 11:00:50\",\n        \"deleted_at\": null,\n        \"project_user\": [\n            {\n                \"id\": 13,\n                \"project_id\": 9,\n                \"userid\": 1,\n                \"owner\": 1,\n                \"top_at\": null,\n                \"created_at\": \"2024-01-12 09:43:18\",\n                \"updated_at\": \"2024-01-12 09:43:18\"\n            }\n        ],\n        \"task_num\": 5,\n        \"task_complete\": 0,\n        \"task_percent\": 0,\n        \"task_my_num\": 5,\n        \"task_my_complete\": 0,\n        \"task_my_percent\": 0,\n        \"owner\": 1,\n        \"owner_userid\": 1\n    },\n    \"timestamp\": 1706362803485,\n    \"executeTime\": 61\n}",
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
      "value" : "1705161979207",
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
      "value" : "64",
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
//TODO判断当前用户有没有权限
import log
import 'cn.dev33.satoken.stp.StpUtil';
//添加统计信息
var project = db.table("projects").where().eq("id", project_id).selectOne()
log.info("project is.  " + project)
var userid = StpUtil.getLoginId()
var AllUser = db.table("project_users").select()
log.info("AllUser value", AllUser)
//查找项目用户信息
var projectuser = db.table("project_users").where().eq("project_id", project_id).select()
//添加用户信息
project.project_user = projectuser
//统计信息
//任务总数
var taskBaseSelect = db.table("project_tasks").where().eq("project_id", project_id).isNull("archived_at")
var taskNum = taskBaseSelect.select()
project.task_num = taskNum.size()

//任务完成数
var taskComplete = db.table("project_tasks").where().eq("project_id", project_id).isNotNull("complete_at").isNull("archived_at").select()
project.task_complete = taskComplete.size()
//任务完成百分比
project.task_percent = project.task_num != 0 ? (project.task_complete / project.task_num * 100)::int : 0

//自己的任务数量
var projectTasks = db.select("""
    SELECT
        project_tasks.*,
        project_task_users.owner,
        1 AS assist
    FROM
        project_tasks
    left JOIN
        project_task_users ON project_tasks.id = project_task_users.task_id
    WHERE
        project_task_users.userid = #{userid}
    AND
        project_task_users.owner = 1 
    AND
        project_task_users.project_id = #{project_id}     
""")

log.info("projectTasks len" + projectTasks.size())

project.task_my_num = projectTasks.size()


//已完成的任务数
var projectCompleteTasks = db.select("""
    SELECT
        project_tasks.*,
        project_task_users.owner,
        1 AS assist
    FROM
        project_tasks
    left JOIN
        project_task_users ON project_tasks.id = project_task_users.task_id
    WHERE
        project_task_users.userid = #{userid}
    AND
        project_task_users.owner = 1 
    AND
        project_task_users.project_id = #{project_id}   
    AND
        project_tasks.complete_at IS NOT NULL
""")

project.task_my_complete = projectCompleteTasks.size()

//任务完成百分比
project.task_my_percent = project.task_my_num != 0 ? (project.task_my_complete / project.task_my_num * 100)::int : 0

//判断当前的用户id和项目负责的id 是否
if (project.userid == userid) {
    project.owner = 1
}

project.owner_userid = project.userid
//获取频道id

// int taskPercent = taskNum != 0 ? (int) ((taskComplete / (float) taskNum) * 100) : 0;
return project