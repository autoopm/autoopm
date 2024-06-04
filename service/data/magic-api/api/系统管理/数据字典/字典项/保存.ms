{
  "properties" : { },
  "id" : "695ff3257c314ea4bfa63edeaa511af0",
  "script" : null,
  "groupId" : "376f26eb43a44a3daeafd27020a96f48",
  "name" : "保存",
  "createTime" : 1646490239437,
  "updateTime" : 1644121691372,
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
    "value" : "dict:items:save",
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
var valueCount = db.selectInt("select count(1) from sys_dict_items where is_del = 0 and dict_id = #{data.dictId} and value = #{data.value} ?{id, and id != #{data.id}}")
if(valueCount > 0){
    exit 0,'值已存在'
}
return db.table("sys_dict_items").primary("id").saveOrUpdate(data)