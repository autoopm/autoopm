{
  "properties" : { },
  "id" : "24e7f553acdd45338192b1b480b7911b",
  "script" : null,
  "groupId" : "f2a82a98ff1d49a3904430542a3d776d",
  "name" : "删除任务文件-待完善",
  "createTime" : 1717060653809,
  "updateTime" : 1713024593911,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "filedelete",
  "method" : "GET",
  "parameters" : [ {
    "name" : "file_id",
    "value" : null,
    "description" : "文件id",
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
//确认文件是否还存在
import log
var builder = db.table("project_task_files").where().eq("file_id", file_id)
var file = builder.selectOne()
if (file == null) {
    exit 400, '文件不存在或已被删除';
}
//查找项目名称
var useTask = db.table("project_tasks").where().eq("id", file.task_id).selectOne()
if (useTask != null) {
    //TODO 推送消息
}

result = builder.delete() //TODO 修改成软删除

log.info('删除任务文件---->' + result)
return 'success'