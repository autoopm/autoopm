{
  "properties" : { },
  "id" : "f6e998eaff2c49be807fcb38a1a7d55b",
  "script" : null,
  "groupId" : "8295fc13678d4144bf7363c465247a50",
  "name" : "获取排序号",
  "createTime" : 1646490239501,
  "updateTime" : 1641732159522,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/sort",
  "method" : "GET",
  "parameters" : [ {
    "name" : "pid",
    "value" : "",
    "description" : "",
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
return db.selectInt("""
    select max(sort) + 10 from sys_office where pid = #{pid} and is_del = '0'
""") || 10;