{
  "properties" : { },
  "id" : "8062a0e5c99e4bcca316f0a0594a804b",
  "script" : null,
  "groupId" : "f2538e0f370a4cabab0ae920f5e77ae7",
  "name" : "删除",
  "createTime" : null,
  "updateTime" : 1652170827148,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/delete",
  "method" : "DELETE",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "code:gen:delete",
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
return db.table("sys_gen_info").where().eq("id",id).delete()