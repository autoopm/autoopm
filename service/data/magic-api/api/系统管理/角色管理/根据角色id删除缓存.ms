{
  "properties" : { },
  "id" : "598efb2903ec4e0491fa99e8df0222f9",
  "script" : null,
  "groupId" : "89130d496f6f467c88b22ae4a7f688eb",
  "name" : "根据角色id删除缓存",
  "createTime" : null,
  "updateTime" : 1646493560974,
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
    select user_id from sys_user_role where role_id = #{roleId} and user_id is not null
""")
for(item in userIds){
    SqlCache.delete(`permissions:${item.userId}`)
}