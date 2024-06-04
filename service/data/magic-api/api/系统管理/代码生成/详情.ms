{
  "properties" : { },
  "id" : "2574df3366c24feeb913bea8bd477ec7",
  "script" : null,
  "groupId" : "f2538e0f370a4cabab0ae920f5e77ae7",
  "name" : "详情",
  "createTime" : null,
  "updateTime" : 1648386086354,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/get",
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
return db.selectOne("""
    select * from sys_gen_info where id = #{id}
""")