{
  "properties" : { },
  "id" : "9fe8956f3e79479c825e50dc314bb9bd",
  "script" : null,
  "groupId" : "89130d496f6f467c88b22ae4a7f688eb",
  "name" : "全部",
  "createTime" : null,
  "updateTime" : 1646555166829,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/all",
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
return db.select("""
    select name label, id value from sys_role where is_del = 0
""")