{
  "properties" : { },
  "id" : "0d19b7e1121c4c8189e1871ae2739fb2",
  "script" : null,
  "groupId" : "7cc0839b044d4ab3a208aaf2142fbd7f",
  "name" : "打包文件",
  "createTime" : 1716867156383,
  "updateTime" : 1712671741459,
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
import 'cn.dev33.satoken.stp.StpUtil';
import cn.hutool.core.util.StrUtil;


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