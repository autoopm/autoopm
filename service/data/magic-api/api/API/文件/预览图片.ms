{
  "properties" : { },
  "id" : "c87e3a0463684f0ca79a2b1299d1f491",
  "script" : null,
  "groupId" : "7cc0839b044d4ab3a208aaf2142fbd7f",
  "name" : "预览图片",
  "createTime" : 1717060653334,
  "updateTime" : 1712649651388,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/preview/{id}",
  "method" : "GET",
  "parameters" : [ {
    "name" : "fileName",
    "value" : null,
    "description" : null,
    "required" : false,
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
import cn.hutool.core.util.ObjectUtil
import log;
import request;
import response;
import org.ssssssss.magicboot.utils.MinioUtil;

log.info("id={}", path.id);
log.info("fileName={}", fileName);

var file = db.table('files')
    .where()
    .isNull(deleted_at)
    .eq('id', path.id)
    .selectOne();

if (ObjectUtil.isEmpty(file)) {
    exit 400, '预览失败';
}

MinioUtil.previewfile(file.url, file.name + "." + file.ext, response.getOutputStream())

response.end();