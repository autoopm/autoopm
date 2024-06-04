{
  "properties" : { },
  "id" : "77d393db826d4ba882b7c4b1d32e2e98",
  "script" : null,
  "groupId" : "67b2ce258e24491194b74992958c74aa",
  "name" : "下移",
  "createTime" : null,
  "updateTime" : 1651930976250,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/sort/down",
  "method" : "GET",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "menu:sort:down",
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
        sys_menu 
    WHERE
        is_del = 0 
        AND pid = #{pid}
        AND sort > ( SELECT sort FROM sys_menu WHERE is_del = 0 AND id = #{id} )
    ORDER BY
        sort 
        LIMIT 1
""")
if(top){
    db.update("""
        update sys_menu set sort = #{top.sort} where id = #{id}
    """)
    db.update("""
        update sys_menu set sort = #{sort} where id = #{top.id}
    """)
}