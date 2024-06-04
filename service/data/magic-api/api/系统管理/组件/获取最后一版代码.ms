{
  "properties" : { },
  "id" : "530c445f0e69494581d1420cd5311440",
  "script" : null,
  "groupId" : "6f106ebdee21489db34b956f7770ff03",
  "name" : "获取最后一版代码",
  "createTime" : null,
  "updateTime" : 1710082965250,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/getLastCode",
  "method" : "GET",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "component:get:last:code",
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
    select 
        source_code,
        create_date,
        (select username from sys_user where id = sdch.create_by) create_by
    from sys_dynamic_component_history sdch where component_id = #{componentId}
    order by create_date desc limit 1
""")