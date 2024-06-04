{
  "properties" : { },
  "id" : "96336e6177d143c1a2259685f71cd615",
  "script" : null,
  "groupId" : "67b2ce258e24491194b74992958c74aa",
  "name" : "根据菜单id清除缓存",
  "createTime" : null,
  "updateTime" : 1646493562232,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/cache/delete",
  "method" : "GET",
  "parameters" : [ ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import org.ssssssss.magicapi.modules.db.cache.SqlCache
var userIds = db.select("""
    select user_id from sys_user_role where role_id in (
        select role_id from sys_role_menu where menu_id = #{menuId}
    ) and user_id is not null
""")
for(item in userIds){
    SqlCache.delete(`permissions:${item.userId}`)
}