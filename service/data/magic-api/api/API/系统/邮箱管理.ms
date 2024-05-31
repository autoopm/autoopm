{
  "properties" : { },
  "id" : "bdb87361e519436f845da605a0447396",
  "script" : null,
  "groupId" : "a0d32feaa58a4d318032215149d5cf40",
  "name" : "邮箱管理",
  "createTime" : 1717060653715,
  "updateTime" : 1713325160606,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/setting/email",
  "method" : "GET",
  "parameters" : [ {
    "name" : "smtp_server",
    "value" : null,
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "port",
    "value" : null,
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"smtp_server\": \"\",\n        \"port\": \"\",\n        \"account\": \"\",\n        \"password\": \"\",\n        \"reg_verify\": \"close\",\n        \"notice_msg\": \"close\",\n        \"msg_unread_user_minute\": \"-1\",\n        \"msg_unread_group_minute\": \"-1\",\n        \"ignore_addr\": \"\"\n    },\n    \"timestamp\": 1706607921540,\n    \"executeTime\": 5\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import log

if (type == "save") { //TODO 邮箱保存未实现
   //判断当前用户是否是管理员
   
} else {
    var system = db.table("settings").where().eq("name", "emailSetting").selectOne()
    log.info('email value ' + system)
    log.info('email value: ' + system::json)
    var result = system.setting::json
    return result
}