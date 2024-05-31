{
  "properties" : { },
  "id" : "07b4cadafed54738b6f9fa439930af56",
  "script" : null,
  "groupId" : "f2a82a98ff1d49a3904430542a3d776d",
  "name" : "获取任务详细描述",
  "createTime" : 1717060653863,
  "updateTime" : 1713024594479,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/content",
  "method" : "GET",
  "parameters" : [ {
    "name" : "task_id",
    "value" : "217",
    "description" : null,
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"id\": 44,\n        \"project_id\": 111,\n        \"task_id\": 217,\n        \"content\": \"<p>4444441213131231313131</p>\\n<p><img src=\\\"http://82.157.62.190:9000/task/2024-03-02/2383d8d71e8b43b4bdd71fb47f804e47.jpeg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20240301%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240301T172451Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=edbf883076d5f60f88d1edd59a7a6acf65a07957277306720950dffe840557a1\\\" original-width=\\\"1814\\\" original-height=\\\"1068\\\" /><img src=\\\"http://82.157.62.190:9000/task/2024-03-02/2383d8d71e8b43b4bdd71fb47f804e47.jpeg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20240301%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240301T172451Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=edbf883076d5f60f88d1edd59a7a6acf65a07957277306720950dffe840557a1\\\" original-width=\\\"1814\\\" original-height=\\\"1068\\\" /></p>\\n\"\n    },\n    \"timestamp\": 1709314554762,\n    \"executeTime\": 25\n}",
  "description" : null,
  "requestBodyDefinition" : {
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
      "name" : "task_id",
      "value" : "217",
      "description" : "任务id",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "content",
      "value" : "<p>121313</p>",
      "description" : "",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    } ]
  },
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
        "name" : "id",
        "value" : "44",
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
        "name" : "project_id",
        "value" : "111",
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
        "name" : "task_id",
        "value" : "217",
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
        "name" : "content",
        "value" : "",
        "description" : "",
        "required" : false,
        "dataType" : "String",
        "type" : null,
        "defaultValue" : null,
        "validateType" : "",
        "error" : "",
        "expression" : "",
        "children" : [ ]
      } ]
    }, {
      "name" : "timestamp",
      "value" : "1709314391849",
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
      "value" : "12",
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
import log
import 'org.ssssssss.magicboot.utils.MinioUtil';
var useTask = db.table("project_tasks").where().eq("id", task_id).selectOne()
if (useTask == null) {
    exit 400, "任务不存在";
}

log.info("useTask.content----: " + useTask.id)
log.info("useTask.content----: " + useTask.name)
log.info("useTask.content----: " + useTask.desc)
log.info(useTask)
log.info("useTask.content----: ")


if (useTask.desc == "") {
    return {}
}

taskContent = db.table("project_task_contents").where().eq("task_id", useTask.id).orderByDesc("id").selectOne()

log.info("contentValue11111111----: ")
log.info(taskContent.content)
log.info("taskContent")

var result = {}
if (taskContent != null) {

    json = taskContent.content::json
    log.info("json value" + json)
    // url = json.url
    // log.info("url value" + url)
    contentValue = MinioUtil.getContent(json.url)
    log.info("contentValue: " + contentValue)
    result.id = taskContent.id
    result.project_id = useTask.project_id
    result.task_id = useTask.id
    //获取远程url中的minio中的文件的内容
    result.content = contentValue

}
return result