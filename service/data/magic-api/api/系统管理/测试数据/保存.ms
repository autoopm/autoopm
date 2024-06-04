{
  "properties" : { },
  "id" : "d31e3bea5666449d90fa95779adfb61f",
  "script" : null,
  "groupId" : "42d241c0bb18476f8dabf92c2e4e2324",
  "name" : "保存",
  "createTime" : 1646490239463,
  "updateTime" : 1642312068428,
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
  } ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
return db.table("sys_test_data").primary("id").saveOrUpdate(data)