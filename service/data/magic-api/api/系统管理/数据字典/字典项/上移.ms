{
  "properties" : { },
  "id" : "08f29d784ed94b318ea2209997b6d426",
  "script" : null,
  "groupId" : "376f26eb43a44a3daeafd27020a96f48",
  "name" : "上移",
  "createTime" : null,
  "updateTime" : 1652170402804,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/sort/up",
  "method" : "GET",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "dict:items:sort:up",
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
        sys_dict_items
    WHERE
        is_del = 0 
        and dict_id = #{dictId}
        AND sort < ( SELECT sort FROM sys_dict_items WHERE is_del = 0 AND id = #{id} ) 
    ORDER BY
        sort DESC 
        LIMIT 1
""")
if(top){
    db.update("""
        update sys_dict_items set sort = #{top.sort} where id = #{id}
    """)
    db.update("""
        update sys_dict_items set sort = #{sort} where id = #{top.id}
    """)
}