{
  "properties" : { },
  "id" : "21b1658fce9345c7bcebcdda5efac173",
  "script" : null,
  "groupId" : "f2a82a98ff1d49a3904430542a3d776d",
  "name" : "获取任务文件列表",
  "createTime" : 1716867161502,
  "updateTime" : 1713024594331,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/files",
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
//TODO 打算集成新的东西来实现
task = db.table("project_tasks").where().eq("id", task_id).selectOne()

if (task == null) {
    exit 400, '任务不存在';
}
files = db.table("project_task_files").where().eq("task_id", task_id).orderByDesc("id").select();
return files.size() > 0 ? files : []