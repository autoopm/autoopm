{
  "properties" : { },
  "id" : "3564ad867beb48898f85c44bd3f7aa3f",
  "script" : null,
  "groupId" : "67b2ce258e24491194b74992958c74aa",
  "name" : "删除",
  "createTime" : null,
  "updateTime" : 1712806455648,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/delete",
  "method" : "DELETE",
  "parameters" : [ {
    "name" : "id",
    "value" : "b1851d1b13594e71840103c11a37a669",
    "description" : "",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "options" : [ {
    "name" : "permission",
    "value" : "menu:delete",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": null,\n    \"timestamp\": 1641201245421,\n    \"executeTime\": 7\n}",
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
  "responseBodyDefinition" : {
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
    "children" : [ {
      "name" : "code",
      "value" : "200",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "message",
      "value" : "success",
      "description" : "",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "data",
      "value" : "null",
      "description" : "",
      "required" : false,
      "dataType" : "Object",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "timestamp",
      "value" : "1641201245421",
      "description" : "",
      "required" : false,
      "dataType" : "Long",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "executeTime",
      "value" : "7",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    } ]
  }
}
================================
import org.ssssssss.magicapi.modules.db.cache.SqlCache
var userIds = db.select("""
    select user_id from sys_user_role where role_id in (
        select role_id from sys_role_menu where menu_id = #{id}
    ) and user_id is not null
""")
for(item in userIds){
    SqlCache.delete(`permissions:${item.userId}`)
}
SqlCache.delete('permissions:1')

let recursionDelete = (list) => {
    list.forEach(it => {
        db.table('sys_role_menu').where().eq("menu_id",it.id).delete();
        db.table("sys_menu").logic().where().eq("id",it.id).delete()
        let children = db.select("select id from sys_menu where is_del = 0 and pid = #{it.id}")
        if(children && children.size() > 0){
            recursionDelete(children)
        }
    })
}
recursionDelete(db.select("select id from sys_menu where is_del = 0 and pid = #{id}"))

db.table('sys_role_menu').where().eq("menu_id",id).delete();
return db.table("sys_menu").logic().where().eq("id",id).delete();