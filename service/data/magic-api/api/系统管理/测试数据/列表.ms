{
  "properties" : { },
  "id" : "6d50d6c8884f4624b2bf8fd537ac34f6",
  "script" : null,
  "groupId" : "42d241c0bb18476f8dabf92c2e4e2324",
  "name" : "列表",
  "createTime" : null,
  "updateTime" : 1648647148457,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/list",
  "method" : "POST",
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
/**
 * db  东北  本级
 * nm 内蒙  本级及子级
 * mxd2  全部
 * mxd  自定义
 */
// import '@/permission/office' as permissionOffice;
// var userIds = permissionOffice()

// return db.page("""
//     select id,name from sys_test_data where 1 = 1 
//     ?{userIds, and create_by in (#{userIds})}
// """)

import '@/permission/office' as permissionOffice;
var userIds = permissionOffice()

return db.table("sys_test_data").where().in("create_by",userIds).page()