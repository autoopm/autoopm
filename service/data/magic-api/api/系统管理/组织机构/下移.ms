{
  "properties" : { },
  "id" : "5f8edf5b8045475f92049270bcf0739a",
  "script" : null,
  "groupId" : "8295fc13678d4144bf7363c465247a50",
  "name" : "下移",
  "createTime" : null,
  "updateTime" : 1651932356319,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/sort/down",
  "method" : "GET",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "office:sort:down",
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
var top = db.selectOne("""
    SELECT
        id,
        sort
    FROM
        sys_office 
    WHERE
        is_del = 0 
        AND pid = #{pid}
        AND sort > ( SELECT sort FROM sys_office WHERE is_del = 0 AND id = #{id} )
    ORDER BY
        sort 
        LIMIT 1
""")
if(top){
    db.update("""
        update sys_office set sort = #{top.sort} where id = #{id}
    """)
    db.update("""
        update sys_office set sort = #{sort} where id = #{top.id}
    """)
}