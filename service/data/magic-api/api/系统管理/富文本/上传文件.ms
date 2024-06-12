{
  "properties" : { },
  "id" : "4b61ead2862144b2a9115719c4550aa5",
  "script" : null,
  "groupId" : "7eeba36706c24c1484ee4e84ad829f9b",
  "name" : "上传文件",
  "createTime" : null,
  "updateTime" : 1717813184885,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/uploadFile",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ ],
  "requestBody" : "{\r\n\t\r\n}",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import 'org.ssssssss.magicboot.utils.FileUtils'
import request;
import response;

return response.json(FileUtils.saveFile(request.getFile("file")));