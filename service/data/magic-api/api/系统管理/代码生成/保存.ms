{
  "properties" : { },
  "id" : "5ce5b7d99dd044a9b837c57df7aa9ca5",
  "script" : null,
  "groupId" : "f2538e0f370a4cabab0ae920f5e77ae7",
  "name" : "保存",
  "createTime" : null,
  "updateTime" : 1648391254377,
  "lock" : null,
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
if(data.id){
    data.updateDate = new Date()
}
return db.table("sys_gen_info").primary("id").save(data)