{
  "properties" : { },
  "id" : "d5ccf62c6d2c482e995ce7fe237e9ed3",
  "script" : null,
  "groupId" : "d95a58e77d314370862ffc4cdfdb8283",
  "name" : "列表",
  "createTime" : null,
  "updateTime" : 1692848227765,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/list",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "online:view",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": [\n        \"0bde782e-fb15-4aaa-9795-406f644a513d\",\n        \"08d818e1-62bb-426e-9eba-c88458c40e55\"\n    ],\n    \"timestamp\": 1692848223759,\n    \"executeTime\": 10\n}",
  "description" : null,
  "requestBodyDefinition" : null,
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
        "name" : "",
        "value" : "cb63a01c-63d7-4722-a2c4-48fffa4b3502",
        "description" : "",
        "required" : false,
        "dataType" : "String",
        "type" : null,
        "defaultValue" : null,
        "validateType" : "",
        "error" : "",
        "expression" : "",
        "children" : [ ]
      } ]
    }, {
      "name" : "timestamp",
      "value" : "1647396771372",
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
      "value" : "11",
      "description" : "",
      "required" : false,
      "dataType" : "Object",
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
import cn.dev33.satoken.stp.StpUtil
var tokens = StpUtil.searchTokenValue("", 0, -1, true).map(it => it.replace('token:login:token:', ''))
return db.page("""
    select 
        su.id,
        su.username,
        so.name office_name,
        sll.address,
        sll.token,
        sll.ip,
        sll.browser,
        sll.os,
        sll.create_date
    from sys_login_log sll left join sys_user su on sll.username = su.username left join sys_office so on su.office_id = so.id
    where sll.token in (#{tokens})
    ?{username, and su.username like concat('%', #{username}, '%')}
    ?{ip, and sll.ip like concat('%', #{ip}, '%')}
    order by sll.create_date desc
""")