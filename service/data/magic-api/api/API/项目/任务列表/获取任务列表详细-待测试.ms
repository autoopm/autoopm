{
  "properties" : { },
  "id" : "a392458067ad4bf597af2a96077fbbea",
  "script" : null,
  "groupId" : "45cfe6d453b047dd9a1c2b8c9f241edf",
  "name" : "获取任务列表详细-待测试",
  "createTime" : 1717060653922,
  "updateTime" : 1713024594939,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/one",
  "method" : "GET",
  "parameters" : [ {
    "name" : "column_id",
    "value" : null,
    "description" : "列表ID",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "deleted",
    "value" : null,
    "description" : "是否读取已删除  all：所有 yes：已删除 no：未删除（默认）",
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
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import 'cn.dev33.satoken.stp.StpUtil';
import log

var builder = db.table("project_columns").where().eq("id", column_id)

if (deleted == 'all') {
    //不处理，就是查所有
} else if (deleted == 'yes') {
    builder.notNull('deleted_at')
}
column = builder.selectOne()
if (column == null) {
    exit 400, '列表不存在';
}
return column