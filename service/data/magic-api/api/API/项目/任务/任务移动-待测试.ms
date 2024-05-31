{
  "properties" : { },
  "id" : "069277c0c6d6413fa53d55015cb1ac71",
  "script" : null,
  "groupId" : "f2a82a98ff1d49a3904430542a3d776d",
  "name" : "任务移动-待测试",
  "createTime" : 1717060653785,
  "updateTime" : 1713024593499,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/move",
  "method" : "GET",
  "parameters" : [ {
    "name" : "task_id",
    "value" : null,
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
    "name" : "project_id",
    "value" : null,
    "description" : "项目ID",
    "required" : true,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "column_id",
    "value" : null,
    "description" : "列ID",
    "required" : true,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "flow_item_id",
    "value" : null,
    "description" : "工作流id",
    "required" : true,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "owner",
    "value" : null,
    "description" : "负责人",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "assist",
    "value" : null,
    "description" : "协助人",
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
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
//判断新列表是否存在
column = db.table("project_columns").where().eq("id", column_id).selectOne()
if (column == null) {
    exit 400, '列表不存在';
}

//
useTask = db.table("project_tasks").where().eq("id", task_id).selectOne()
if (useTask == null) {
    exit 400, '任务不存在';

}
oldColumn = db.table("project_columns").where().eq("id", useTask.column_id).selectOne()

if (oldColumn.id != column.id) { //id不一样的时候执行移动
    result = db.table("projects_tasks").primary("id").update({
        id: task_id,
        column_id: column_id
    })
    if (result) {
        task = db.table("project_tasks").where().eq("id", task_id).selectOne()
        return task
    }
}
exit 400, '移动异常';
//返回无操作啊