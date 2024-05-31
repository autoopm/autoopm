{
  "properties" : { },
  "id" : "6c42b4e0d502406aa2e5a433137307b4",
  "script" : null,
  "groupId" : "45cfe6d453b047dd9a1c2b8c9f241edf",
  "name" : "获取任务列表-已完成",
  "createTime" : 1717060653917,
  "updateTime" : 1713024594861,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/lists",
  "method" : "GET",
  "parameters" : [ {
    "name" : "project_id",
    "value" : "65",
    "description" : "项目ID",
    "required" : true,
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
    "description" : "当前页，默认:1",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "pagesize",
    "value" : null,
    "description" : "每页显示数量，默认:100，最大:200",
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
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": [\n        {\n            \"id\": 156,\n            \"projectId\": 65,\n            \"name\": \"\",\n            \"color\": \"\",\n            \"sort\": 0,\n            \"createdAt\": null,\n            \"updatedAt\": null,\n            \"deletedAt\": null\n        },\n        {\n            \"id\": 160,\n            \"projectId\": 65,\n            \"name\": \"测试列表1\",\n            \"color\": \"\",\n            \"sort\": 0,\n            \"createdAt\": null,\n            \"updatedAt\": null,\n            \"deletedAt\": null\n        },\n        {\n            \"id\": 161,\n            \"projectId\": 65,\n            \"name\": \"VR\",\n            \"color\": \"\",\n            \"sort\": 0,\n            \"createdAt\": null,\n            \"updatedAt\": null,\n            \"deletedAt\": null\n        }\n    ],\n    \"timestamp\": 1706248632811,\n    \"executeTime\": 4\n}",
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
      "value" : "1706066844557",
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
      "value" : "15",
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
//判断项目是否已归档，自己在不在项目中
var useProject = db.table("projects").where().eq("id", project_id).notNull("archived_at").selectOne()
if (useProject == null) {
    exit 400, '项目不存在或已归档'
}

var result = {
    data
}

//TODO 分页暂时不考虑
var columnList = db.table("project_columns").where().eq("project_id", project_id).orderBy('sort').orderBy('id').select()
result.data = columnList
return result