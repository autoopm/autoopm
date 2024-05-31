{
  "properties" : { },
  "id" : "cbcf20b412f54f62907a7d31287c533e",
  "script" : null,
  "groupId" : "7cc0839b044d4ab3a208aaf2142fbd7f",
  "name" : "获取文件列表",
  "createTime" : 1717060653318,
  "updateTime" : 1717055458144,
  "lock" : "0",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": [],\n    \"timestamp\": 1717055443713,\n    \"executeTime\": 203\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import '@/file/getFileListByPermission' as getFileListByPermission;
import 'cn.dev33.satoken.stp.StpUtil';
import org.ssssssss.magicboot.utils.MinioUtil;
import log;
import env;

var userId = StpUtil.getLoginId()

//检查文件并创建桶
var bucketName = env.get('minio.bucketName')
log.info("env bucketName-->"+bucketName)
MinioUtil.checkBucket(bucketName)


var fileList = getFileListByPermission(null, null, userId,pid);
log.info('fileList:' + fileList);
return fileList;