{
  "properties" : { },
  "id" : "ddcc356a6e3d4ed6b901be999bdb90c0",
  "script" : null,
  "groupId" : "6f106ebdee21489db34b956f7770ff03",
  "name" : "组件历史",
  "createTime" : null,
  "updateTime" : 1710083257848,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/history",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "component:history:list",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"total\": 164,\n        \"list\": [\n            {\n                \"id\": \"0474e1a3d44247f0ac09bcae02bdcff2\",\n                \"createDate\": \"2024-03-07 11:34:35\",\n                \"createby\": \"admin\"\n            },\n            {\n                \"id\": \"04b98d9889bf451d8d398cef3d32f899\",\n                \"createDate\": \"2024-03-07 14:09:20\",\n                \"createby\": \"admin\"\n            },\n            {\n                \"id\": \"04e7c8c5fb81490ca9e4cffc12e9a622\",\n                \"createDate\": \"2024-03-07 12:15:09\",\n                \"createby\": \"admin\"\n            },\n            {\n                \"id\": \"05db93da5de1442bafd1b3638693f1da\",\n                \"createDate\": \"2024-03-07 14:12:43\",\n                \"createby\": \"admin\"\n            },\n            {\n                \"id\": \"0749a7bbd1c4473cacf3a74175288f74\",\n                \"createDate\": \"2024-03-07 11:10:23\",\n                \"createby\": \"admin\"\n            },\n            {\n                \"id\": \"07b8216e94c4439688843f177f43404f\",\n                \"createDate\": \"2024-03-07 11:11:29\",\n                \"createby\": \"admin\"\n            },\n            {\n                \"id\": \"081394d27c8b43f98ebdf3b092265384\",\n                \"createDate\": \"2024-03-07 15:02:30\",\n                \"createby\": \"admin\"\n            },\n            {\n                \"id\": \"0affca0c150942e5bab5d796c4db14aa\",\n                \"createDate\": \"2024-03-07 14:04:52\",\n                \"createby\": \"admin\"\n            },\n            {\n                \"id\": \"0dc4027ff5e64dae91e6cbec41605e3d\",\n                \"createDate\": \"2024-03-07 11:16:29\",\n                \"createby\": \"admin\"\n            },\n            {\n                \"id\": \"0f929ebc16d74c2488425ff46fc3d289\",\n                \"createDate\": \"2024-03-07 14:12:30\",\n                \"createby\": \"admin\"\n            }\n        ]\n    },\n    \"timestamp\": 1709803746297,\n    \"executeTime\": 94\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
return db.page("""
    select 
        id,
        create_date,
        (select username from sys_user where id = sdch.create_by) create_by
    from sys_dynamic_component_history sdch
    where component_id = #{componentId}
    order by create_date desc
""")