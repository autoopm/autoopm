{
  "properties" : { },
  "id" : "03c2c9614e5b47f48f61f4f7759fe353",
  "script" : null,
  "groupId" : "8295fc13678d4144bf7363c465247a50",
  "name" : "保存",
  "createTime" : null,
  "updateTime" : 1647615397163,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/save",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ {
    "name" : "wrap_request_parameter",
    "value" : "data",
    "description" : "包装请求参数到一个变量中",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "permission",
    "value" : "office:save",
    "description" : "允许拥有该权限的访问",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "requestBody" : "{}",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : null,
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
    "children" : [ ]
  },
  "responseBodyDefinition" : null
}
================================
var codeCount = db.selectInt("select count(1) from sys_office where is_del = 0 and code = #{code} ?{id, and id != #{id}}")
if(codeCount > 0){
    exit 0,'机构编码已存在'
}
return db.table("sys_office").primary("id").saveOrUpdate(data);