{
  "properties" : { },
  "id" : "a0cafd9e4f4b444f84987e00cda5b817",
  "script" : null,
  "groupId" : "fbe74c5bc9f04c308679a525a09005a6",
  "name" : "打包文件",
  "createTime" : null,
  "updateTime" : 1718975274095,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/download/pack",
  "method" : "GET",
  "parameters" : [ {
    "name" : "ids",
    "value" : null,
    "description" : "文件ID，格式: id, id2, id3",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "name",
    "value" : null,
    "description" : "下载文件名",
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
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import cn.dev33.satoken.stp.StpUtil
import cn.hutool.core.util.StrUtil

var userId = StpUtil.getLoginId()
var fileName = null;
if (StrUtil.isNotEmpty(name)) {
    fileName = name.replaceAll("[/\\\\:*?\"<>|]", "");
}
if (StrUtil.isEmpty(fileName)) {
    fileName = 'Package_' + userId;
}

fileName = fileName + '_' + date_format(new Date); + '.zip';

if (StrUtil.isEmpty(ids)) {
    exit 400, '请选择下载的文件或文件夹';
}
if (StrUtil.split(ids, ',') > 100) {
    exit 400, '一次最多可以下载100个文件或文件夹';
}
return 'Hello magic-api'