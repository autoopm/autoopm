{
  "properties" : { },
  "id" : "631a594c0e974efc8deb47fe81892e03",
  "script" : null,
  "groupId" : "45cfe6d453b047dd9a1c2b8c9f241edf",
  "name" : "修改任务列表-待测试",
  "createTime" : 1717060653875,
  "updateTime" : 1713024594630,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/update",
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
    "name" : "name",
    "value" : null,
    "description" : "列表名称",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "color",
    "value" : null,
    "description" : "颜色",
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
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import log
import '@/project/use' as use
import '@/project/log' as addlog

//查找是否有这个列表
var column = db.table("project_columns").where().eq("id", column_id).selectOne()
if (column == null) {
    exit 400, '列表不存在'
}
//判断项目是否已归档，自己在不在项目中
var useProject = use()

//修改任务列表
var val = db.transaction(() => {
    var updateData = {}
    //判断名称修改是否一致 
    if (name != null && column.name != name) {
        updateData.name = name
        //TODO 添加日志
    }

    //颜色修改
    if (color != null && column.color != color) {
        updateData.color = color
        //TODO 添加日志
    }
    updateData.id = column.id
    builder = db.table("project_columns").primary("id").update(updateData)
})

//推送修改成功消息
return '修改成功'