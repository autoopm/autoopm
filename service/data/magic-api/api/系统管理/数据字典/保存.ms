{
  "properties" : { },
  "id" : "cbf24a795f6441d6af123d6dff065e37",
  "script" : null,
  "groupId" : "c7ce65f5b3cf4aaa913f6fec7d35d176",
  "name" : "保存",
  "createTime" : 1646490239430,
  "updateTime" : 1644121671060,
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
    "value" : "dict:save",
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
  "requestBody" : "{\n\n}",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
var typeCount = db.selectInt("select count(1) from sys_dict where is_del = 0 and type = #{data.type} ?{id, and id != #{data.id}}")
if(typeCount > 0){
    exit 0,'类型已存在'
}
return db.table("sys_dict").primary("id").saveOrUpdate(data)