{
  "properties" : { },
  "id" : "f9a5956afdfd4492966b1a3c04dbadf6",
  "script" : null,
  "groupId" : "89130d496f6f467c88b22ae4a7f688eb",
  "name" : "保存",
  "createTime" : null,
  "updateTime" : 1665500810912,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : "guyi",
  "path" : "/save",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "role:save",
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
import '@get:/system/role/cache/delete' as cacheDelete

var codeCount = db.selectInt("select count(1) from sys_role where is_del = 0 and code = #{code} ?{id, and id != #{id}}")
if(codeCount > 0){
    exit 0,'角色编码已存在'
}

var role = {
    code,
    permission,
    descRibe,
    type,
    name,
    sort,
    id
}
if(id){
    db.table("sys_role_menu").where().eq("role_id",id).delete()
}
id = db.table("sys_role").primary("id").saveOrUpdate(role);
for(menuId in menus.split(',')){
    db.table("sys_role_menu").column("menu_id",menuId).column("role_id", id).insert();
}
db.table("sys_role_office").where().eq("role_id",id).delete()
if(offices && permission == 1){
    for(officeId in offices.split(',')){
        db.table("sys_role_office").column("office_id",officeId).column("role_id", id).insert();
    }
}
if(id){
    // 先删除数据库 后删除缓存 不然拦截器会请求查询数据库 查到的还是老数据
    var roleId = id
    cacheDelete()
}