{
  "properties" : { },
  "id" : "e294c30226fa4e75ab474294a1c9e789",
  "script" : null,
  "groupId" : "0c2d9f4051a44b37a9a0f361f4e13b75",
  "name" : "修改项目",
  "createTime" : 1717060653723,
  "updateTime" : 1714468474154,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/update",
  "method" : "GET",
  "parameters" : [ {
    "name" : "project_id",
    "value" : "9",
    "description" : null,
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "expression",
    "error" : "",
    "expression" : "",
    "children" : null
  }, {
    "name" : "name",
    "value" : "修改的名称2",
    "description" : null,
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "expression",
    "error" : "项目名称最少设置2个字",
    "expression" : "value.length()>2",
    "children" : null
  }, {
    "name" : "desc",
    "value" : "测试的描述22",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "expression",
    "error" : "项目介绍最多只能设置255个字",
    "expression" : "value.length()<255",
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ {
    "name" : "token",
    "value" : "5b57b554-2a1f-4cb9-ae48-1336b58914bc",
    "description" : null,
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": \"修改项目接口\",\n    \"timestamp\": 1705324211263,\n    \"executeTime\": 20399\n}",
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
      "value" : "1705322951677",
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
      "value" : "427",
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
//TODO  已归档或者其他状态下的项目不能操作
//查找项目信息
var useProject = db.table("projects").where().eq("id",project_id).notNull("archived_at").selectOne()
if (useProject ==null) {
    exit 400, '项目不存在或已归档'
}
log.info('useProject:'+useProject)

var val = db.transaction(() => {
    var logDetail = "修改项目名称"+useProject.name+"=>"+name
    //插入日志
    var project_log = db.table('project_logs').insert({
        project_id: project_id,
        column_id: 0,
        task_id: 0,
        userid: userid,
        detail: logDetail
    })

    //更新聊天室的信息（主要是名称）
    db.table('web_socket_dialogs').primary('channel_id').update({
        channel_id: useProject.dialogId,
         name: name
    })

    //更新项目信息
    db.table('projects').primary('id').update({
        id: project_id,
        name: name
    })

    // log.info('desc:'+desc)
    if (desc1){
        var logDetail = "修改项目介绍"
        //插入日志
        var project_log = db.table('project_logs').insert({
            project_id: project_id,
            column_id: 0,
            task_id: 0,
            userid: userid,
            detail: logDetail
        })  

        //  var descStr = desc
         log.info('desc1:'+desc1)
         log.info('project_id:'+project_id)
        //更新项目信息 这里分成2步执行，需要优化成一个sql执行
        // db.table('projects').primary('id').update({
        //     id: project_id,
        //     `desc`: desc
        //  })
    }else{
         log.info('描述为空')
    }
});


//推送更新通知


return '修改项目接口'