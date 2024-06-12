{
  "properties" : { },
  "id" : "1127c32c28c24ab6a7d488b5c50c2dbb",
  "script" : null,
  "groupId" : "fbe74c5bc9f04c308679a525a09005a6",
  "name" : "获取文件列表",
  "createTime" : null,
  "updateTime" : 1718096968782,
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
  "responseBody" : "{\n    \"code\": 402,\n    \"message\": \"凭证已过期\",\n    \"data\": null,\n    \"timestamp\": 1717950556809,\n    \"executeTime\": null\n}",
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