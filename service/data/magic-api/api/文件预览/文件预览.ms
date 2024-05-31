{
  "properties" : { },
  "id" : "caa1bb876b0b4960845d96a090a61404",
  "script" : null,
  "groupId" : "9263848cc4844cff9b94615a00ae91cf",
  "name" : "文件预览",
  "createTime" : 1717060653976,
  "updateTime" : 1716520109292,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/preview/{id}",
  "method" : "GET",
  "parameters" : [ {
    "name" : "key",
    "value" : "",
    "description" : null,
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": \"hellow\",\n    \"timestamp\": 1716518853081,\n    \"executeTime\": 4\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import response;
// 清理输入中的空白字符
var trimmedKey = key.trim();

var encodedUrl = "/api/file/preview/" + trimmedKey;

return response.redirect(encodedUrl);