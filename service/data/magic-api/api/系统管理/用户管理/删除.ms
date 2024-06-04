{
  "properties" : { },
  "id" : "c86e4f8fd4bc4d63bfaec8a53ea333cf",
  "script" : null,
  "groupId" : "4f0230049d7e4f39b1e0897cc0f46f9a",
  "name" : "删除",
  "createTime" : null,
  "updateTime" : 1655304921225,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/delete",
  "method" : "DELETE",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "user:delete",
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
  "requestBodyDefinition" : {
    "name" : "",
    "value" : "",
    "description" : "",
    "required" : false,
    "dataType" : "Object",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "",
    "error" : "",
    "expression" : "",
    "children" : [ ]
  },
  "responseBodyDefinition" : null
}
================================
import org.ssssssss.magicapi.modules.db.cache.SqlCache

if(Arrays.asList(id.split(',')).contains('1')){
    exit 500, '不允许删除超级管理员'
}

for(userId in id.split(',')){
    SqlCache.delete(`permissions:${userId}`)
    db.table("sys_user").logic().where().eq("id",userId).delete();
    db.update("""
        delete from sys_user_role where user_id = #{userId}
    """)
}
return true