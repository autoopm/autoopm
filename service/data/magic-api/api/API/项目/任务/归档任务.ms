{
  "properties" : { },
  "id" : "1eea8c09693b497497c75307d5977705",
  "script" : null,
  "groupId" : "f2a82a98ff1d49a3904430542a3d776d",
  "name" : "归档任务",
  "createTime" : 1717060653813,
  "updateTime" : 1713024593991,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/archived",
  "method" : "GET",
  "parameters" : [ {
    "name" : "task_id",
    "value" : null,
    "description" : "任务ID",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "type",
    "value" : null,
    "description" : "String\t 类型  add：归档（默认） recovery：还原归档",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "add",
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
import '@/task/archivedTask' as archivedTask

task = db.table("project_tasks").where().eq("id", task_id).selectOne()
if (task == null) {
    exit 400, '任务不存在';
}

if (task.parent_id > 0) {
    exit 400, '子任务不支持此功能';
}
if (type == 'add') { //归档
    archivedTask(now())
} else if (type == 'recovery') { //还原归档
    archivedTask(null)
}

return '操作成功'