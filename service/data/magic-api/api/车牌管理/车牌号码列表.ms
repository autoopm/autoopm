{
  "properties" : { },
  "id" : "9ff5f8ba4849411481f9416b799e3ece",
  "script" : null,
  "groupId" : "798bf395baaf49038392cbb5d8961c58",
  "name" : "车牌号码列表",
  "createTime" : null,
  "updateTime" : 1716979784261,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/list",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 402,\n    \"message\": \"凭证已过期\",\n    \"data\": null,\n    \"timestamp\": 1716979718416,\n    \"executeTime\": null\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
return db.page("""
    select carnumber,imgsrc from license
    where is_del = 0
    ?{carnumber, and carnumber like concat('%',#{carnumber},'%')}
    order by update_date
""")