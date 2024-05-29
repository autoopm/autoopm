{
  "properties" : { },
  "id" : "a9facac8de6d4084bc3cadfa290fe94b",
  "script" : null,
  "groupId" : "0c2d9f4051a44b37a9a0f361f4e13b75",
  "name" : "置顶项目",
  "createTime" : 1716867159639,
  "updateTime" : 1712799457103,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/top",
  "method" : "GET",
  "parameters" : [ {
    "name" : "project_id",
    "value" : "93",
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
    "value" : "a627f152-6545-4d6d-be87-8abe177aecff",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"id\": 109,\n        \"top_at\": \"2024-04-10 11:12:34\"\n    },\n    \"timestamp\": 1712718754600,\n    \"executeTime\": 11\n}",
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
      "value" : "200",
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
      "value" : "success",
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
        "name" : "id",
        "value" : "109",
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
        "name" : "top_at",
        "value" : "1712718573694",
        "description" : "",
        "required" : false,
        "dataType" : "Long",
        "type" : null,
        "defaultValue" : null,
        "validateType" : "",
        "error" : "",
        "expression" : "",
        "children" : [ ]
      } ]
    }, {
      "name" : "timestamp",
      "value" : "1712718573704",
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
      "value" : "13",
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
import 'cn.hutool.core.date.DateUtil';

import 'cn.dev33.satoken.stp.StpUtil';
if (!StpUtil.isLogin()) {
    exit - 1, '请登录后继续';
}

var userid = StpUtil.getLoginId()
projectUser = db.table("project_users").where().eq("userid", userid).eq("project_id", project_id).selectOne()
if (projectUser == null) {
    exit 400, "项目不存在";
}
topTime = now()
if (projectUser.top_at) {
    topTime = null
}
log.info("topTime ->" + topTime)

result = db.update("""
        UPDATE project_users SET top_at = #{topTime} WHERE userid = #{userid} AND project_id = #{project_id}
        """)
log.info("更新用户表+result" + result)




var last_top_at = DateUtil.date(topTime)::string;
log.info("last_top_at-->" + last_top_at)

var data = {
    id: projectUser.id,
    top_at: last_top_at
}
log.info("data-->" + data)

return data