{
  "properties" : { },
  "id" : "df886e402ace4dfe97f877cabd29c07b",
  "script" : null,
  "groupId" : "f2a82a98ff1d49a3904430542a3d776d",
  "name" : "创建或获取聊天室",
  "createTime" : 1716867160580,
  "updateTime" : 1713024593761,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/dialog",
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
task = db.table("project_tasks").where().eq("id", task_id).selectOne()
if (task == null) {
    exit 400, '任务不存在';
}

return 'Hello magic-api'