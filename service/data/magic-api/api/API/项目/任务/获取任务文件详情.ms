{
  "properties" : { },
  "id" : "8ddf64d5cc344219beb4f9611bfd12fc",
  "script" : null,
  "groupId" : "f2a82a98ff1d49a3904430542a3d776d",
  "name" : "获取任务文件详情",
  "createTime" : 1716867161567,
  "updateTime" : 1713024594405,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/filedetail",
  "method" : "GET",
  "parameters" : [ {
    "name" : "file_id",
    "value" : "",
    "description" : "文件ID",
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
import org.ssssssss.magicboot.utils.MinioUtil
import log
file = db.table("project_task_files").where().eq("id", file_id).selectOne()
if (file == null) {
    exit 400, '文件不存在';
}

var result = {}

//文件实际的路径
result.path = MinioUtil.preview(file.name)
return result