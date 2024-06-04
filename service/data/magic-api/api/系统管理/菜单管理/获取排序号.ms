{
  "properties" : { },
  "id" : "4f966df34dbe41ff8b9941da4671eb2d",
  "script" : null,
  "groupId" : "67b2ce258e24491194b74992958c74aa",
  "name" : "获取排序号",
  "createTime" : 1646490239522,
  "updateTime" : 1641732167291,
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
    select max(sort) + 10 from sys_menu where pid = #{pid} and is_del = '0'
""") || 10;