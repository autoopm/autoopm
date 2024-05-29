{
  "properties" : { },
  "id" : "cbcf20b412f54f62907a7d31287c533e",
  "script" : null,
  "groupId" : "7cc0839b044d4ab3a208aaf2142fbd7f",
  "name" : "获取文件列表",
  "createTime" : 1716867157284,
  "updateTime" : 1712148557120,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "lists",
  "method" : "GET",
  "parameters" : [ {
    "name" : "pid",
    "value" : "0",
    "description" : "父级id",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "0",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": [\n        {\n            \"id\": 13,\n            \"pid\": 0,\n            \"cid\": 0,\n            \"NAME\": \"我修改了值\",\n            \"type\": \"folder\",\n            \"ext\": \"\",\n            \"size\": 0,\n            \"userid\": 0,\n            \"pshare\": null,\n            \"SHARE\": 0,\n            \"created_id\": 0,\n            \"created_at\": null,\n            \"url\": null,\n            \"permission\": 1000\n        },\n        {\n            \"id\": 19,\n            \"pid\": 0,\n            \"cid\": 0,\n            \"NAME\": \"123八戒\",\n            \"type\": \"document\",\n            \"ext\": \"txt\",\n            \"size\": 69506,\n            \"userid\": 0,\n            \"pshare\": null,\n            \"SHARE\": 1,\n            \"created_id\": 0,\n            \"created_at\": null,\n            \"url\": null,\n            \"permission\": 1000\n        }\n    ],\n    \"timestamp\": 1711627841309,\n    \"executeTime\": 3\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import '@/file/getFileListByPermission' as getFileListByPermission;
import 'cn.dev33.satoken.stp.StpUtil';
import log;

var userId = StpUtil.getLoginId()
var fileList = getFileListByPermission(null, null, userId,pid);
log.info('fileList:' + fileList);

return fileList;