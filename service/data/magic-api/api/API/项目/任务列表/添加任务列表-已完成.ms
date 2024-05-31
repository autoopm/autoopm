{
  "properties" : { },
  "id" : "85090fe98f88476b8021c5d2b6d35e84",
  "script" : null,
  "groupId" : "45cfe6d453b047dd9a1c2b8c9f241edf",
  "name" : "添加任务列表-已完成",
  "createTime" : 1717060653909,
  "updateTime" : 1713024594787,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/add",
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
    "name" : "name",
    "value" : "测试列表1",
    "description" : "列表名称",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": null,\n    \"timestamp\": 1706430574825,\n    \"executeTime\": 33\n}",
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
      "value" : "1706430505295",
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
      "value" : "35",
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
var columCount = db.table("project_columns").where().eq("id", project_id).count()
if (columCount > 50) {
    exit 400, '项目列表最多不能超过50个'
}
//根据查询出来的排序+1
var sort = 0
var columnList = db.table("project_columns").where().eq("id", project_id).orderByDesc('sort').selectOne()
if (columnList!=null && columnList.size() > 0) {
    sort = columnList.sort + 1
}

log.info('sort ->' + sort);
var columId = db.table('project_columns').insert({
    project_id: project_id,
    name: name,
    sort: sort
})

log.info('columId ->' + columId);
//添加日志  
//TODO userid用登录用户的
var logDetail = '创建列表' + name
var project_log = db.table('project_logs').insert({
    project_id: projectId,
    column_id: columId,
    task_id: 0,
    userid: userid,
    detail: logDetail
})

var data = db.table("project_columns").where().eq("project_id", project_id).eq("id", columId).selectOne()


log.info('data data  data ->' + data);
// data.project_task = []
//TODO 还要返回添加成功
return data
