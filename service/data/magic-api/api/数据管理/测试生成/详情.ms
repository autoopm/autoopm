{
  "properties" : { },
  "id" : "25ba2ad6bbb14aa0992a1ca2c75140f0",
  "script" : null,
  "groupId" : "7bdcc43555b9419caba2ee722e1aa2d3",
  "name" : "详情",
  "createTime" : 1649260172025,
  "updateTime" : null,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/get",
  "method" : "GET",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "data:test:view",
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
  "requestBody" : null,
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
return db.selectOne("""
    select id,name,sex,head_portrait,remarks from t_data_test where id = #{id}
""")