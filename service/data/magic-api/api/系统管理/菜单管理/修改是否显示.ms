{
  "properties" : { },
  "id" : "62020bd7a49949378e90ce2d14fef8f7",
  "script" : null,
  "groupId" : "67b2ce258e24491194b74992958c74aa",
  "name" : "修改是否显示",
  "createTime" : null,
  "updateTime" : 1651931012437,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/change",
  "method" : "GET",
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
    "value" : "menu:change",
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
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
return db.table("sys_menu").primary("id").update(data)