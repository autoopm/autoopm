{
  "properties" : { },
  "id" : "4b6d4d2d5b8c4292a41b2404fab70640",
  "script" : null,
  "groupId" : "0295f2b4af9145f5a0ea29fa4b797214",
  "name" : "详情",
  "createTime" : null,
  "updateTime" : 1653129248115,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/get",
  "method" : "GET",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "configure:view",
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
return db.selectOne("""
     select id,configure_condition,configure_key,configure_value,configure_name,configure_type,configure_desc_ribe,remarks,create_date from sys_configure where id = #{id}
""")