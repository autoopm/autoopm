{
  "properties" : { },
  "id" : "08d8b48f8479497dbdc5f490eff966a1",
  "script" : null,
  "groupId" : "731c0f0eb0fd4dd792004009271d66fa",
  "name" : "搜索会员列表",
  "createTime" : 1717060653349,
  "updateTime" : 1713325118042,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/search",
  "method" : "GET",
  "parameters" : [ {
    "name" : "project_id",
    "value" : "35",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "dialog_id",
    "value" : null,
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "bot",
    "value" : null,
    "description" : null,
    "required" : false,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "take",
    "value" : null,
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "state",
    "value" : null,
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "sorts.az",
    "value" : null,
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "page",
    "value" : null,
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
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ {
    "name" : "token",
    "value" : "d625f2aa-4130-40d6-9e8a-7d89f44422a6",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": [\n        {\n            \"userid\": 17,\n            \"identity\": null,\n            \"department\": null,\n            \"az\": \"\",\n            \"pinyin\": \"\",\n            \"email\": \"admin7@dootask.com\",\n            \"tel\": \"\",\n            \"nickname\": null,\n            \"profession\": null,\n            \"userimg\": null,\n            \"encrypt\": \"ys95k1\",\n            \"password\": \"8a52ac7cb78bb2bbe35707c2fbc98db1\",\n            \"changepass\": 0,\n            \"login_num\": 0,\n            \"last_ip\": \"\",\n            \"last_at\": null,\n            \"line_ip\": \"\",\n            \"line_at\": null,\n            \"task_dialog_id\": 0,\n            \"created_ip\": \"\",\n            \"disable_at\": null,\n            \"email_verity\": false,\n            \"bot\": 0,\n            \"created_at\": null,\n            \"updated_at\": null\n        },\n        {\n            \"userid\": 21,\n            \"identity\": null,\n            \"department\": null,\n            \"az\": \"A\",\n            \"pinyin\": \"\",\n            \"email\": \"admin12@dootask.com\",\n            \"tel\": \"\",\n            \"nickname\": \"admin12\",\n            \"profession\": null,\n            \"userimg\": null,\n            \"encrypt\": \"dwz4sf\",\n            \"password\": \"2bdb0a7851289c0472f917edc004a8cb\",\n            \"changepass\": 0,\n            \"login_num\": 1,\n            \"last_ip\": \"180.141.67.27\",\n            \"last_at\": 1711102119000,\n            \"line_ip\": \"180.141.67.27\",\n            \"line_at\": 1711102119000,\n            \"task_dialog_id\": 0,\n            \"created_ip\": \"\",\n            \"disable_at\": null,\n            \"email_verity\": false,\n            \"bot\": 0,\n            \"created_at\": null,\n            \"updated_at\": null\n        }\n    ],\n    \"timestamp\": 1711111277529,\n    \"executeTime\": 4\n}",
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
      "value" : "1711110402906",
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
      "value" : "6",
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
import 'cn.dev33.satoken.stp.StpUtil';
import log
// var builder = db.table("users").where()

var users = db.select("""
  SELECT * FROM users 
    <if test="project_id != 0 and project_id != ''">
    WHERE userid IN (SELECT userid FROM project_users WHERE project_id = #{project_id})
    </if>

""")

// //默认排除机器人
// if (bot == null) {
//     builder.eq("bot", 0)
// } else {

// }
// // 默认排除已离职
// if (disable == null) {
//     builder.isNull("disable_at")
// }

// //根据传进来的参数进行筛选
// if (project_id != 0) {

// }

// var users = builder.select()
log.info("users" + users)
return users