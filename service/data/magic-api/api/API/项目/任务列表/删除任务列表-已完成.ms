{
  "properties" : { },
  "id" : "4e21e775e1a54250bdd2d94d07bfc8f0",
  "script" : null,
  "groupId" : "45cfe6d453b047dd9a1c2b8c9f241edf",
  "name" : "删除任务列表-已完成",
  "createTime" : 1717060653889,
  "updateTime" : 1713024594709,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/remove",
  "method" : "GET",
  "parameters" : [ {
    "name" : "column_id",
    "value" : "131",
    "description" : "列表ID（留空为添加列表）",
    "required" : true,
    "dataType" : "String",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": \"删除成功\",\n    \"timestamp\": 1712626109818,\n    \"executeTime\": 19\n}",
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
      "value" : "400",
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
      "value" : "项目不存在或已归档",
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
      "value" : "1712626055690",
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
      "value" : "5",
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
import log
//查找是否有这个列表
var column = db.table("project_columns").where().eq("id", column_id).selectOne()
if (column == null) {
    exit 400, '列表不存在'
}
//判断项目是否已归档，自己在不在项目中
var useProject = db.table("projects").where().eq("id", column.project_id).isNull("archived_at").selectOne()
if (useProject == null) {
    exit 400, '项目不存在或已归档'
}

//删除任务列表
var val = db.transaction(() => {
    var taskList = db.table("project_tasks").where().eq("column_id", column_id).select()
    if (taskList.size() > 0) {
        //遍历任务列表
        for (task in taskList) {
              //删除会话
              var result   =  db.table('web_socket_dialogs').where().eq("id",task.dialog_id).delete()
              log.info("result-->",result)
              //删除任务本身
              result = db.table('project_tasks').where().eq("id",task.id).delete()  
              log.info("result-->",result)
              
        }
    }
    //TODO userid 使用当前登录用户的
    //删除列表  
    var delResult = db.table("project_columns").where().eq("id", column_id).delete()
    log.info("delResult is " + delResult)
    //添加日志
    var logDetail = '删除列表' + name
    var project_log = db.table('project_logs').insert({
        project_id: projectId,
        column_id: 0,
        task_id: 0,
        userid: userid,
        detail: logDetail
    })

})
return '删除成功'