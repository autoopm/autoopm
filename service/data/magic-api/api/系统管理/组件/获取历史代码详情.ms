{
  "properties" : { },
  "id" : "f21ff197058a47e0ba1e1c6c714081ce",
  "script" : null,
  "groupId" : "6f106ebdee21489db34b956f7770ff03",
  "name" : "获取历史代码详情",
  "createTime" : null,
  "updateTime" : 1710083294611,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/history/detail",
  "method" : "GET",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "component:history:detail",
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
return db.selectValue("""
    select source_code from sys_dynamic_component_history where id = #{id} and is_del = 0
""")