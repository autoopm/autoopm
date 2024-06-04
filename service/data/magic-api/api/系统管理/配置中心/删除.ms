{
  "properties" : { },
  "id" : "368c6debc18342c6abb46e795336d573",
  "script" : null,
  "groupId" : "0295f2b4af9145f5a0ea29fa4b797214",
  "name" : "删除",
  "createTime" : null,
  "updateTime" : 1653129244605,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/delete",
  "method" : "DELETE",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "configure:delete",
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
return db.table('sys_configure').logic().where().eq('id', id).delete()