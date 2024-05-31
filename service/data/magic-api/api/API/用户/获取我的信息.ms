{
  "properties" : { },
  "id" : "1d82a14a40884ed39a49e497d1f1a1f6",
  "script" : null,
  "groupId" : "731c0f0eb0fd4dd792004009271d66fa",
  "name" : "获取我的信息",
  "createTime" : 1717060653663,
  "updateTime" : 1713325116297,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/info",
  "method" : "GET",
  "parameters" : [ {
    "name" : "token",
    "value" : "52fbbf24-17c6-4825-96a3-8cd04a437dc1",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"userid\": 6,\n        \"identity\": [\n            \"\",\n            \"admin\"\n        ],\n        \"department\": \"\",\n        \"az\": \"A\",\n        \"pinyin\": \"\",\n        \"email\": \"admin@autoo.com\",\n        \"tel\": \"\",\n        \"nickname\": \"Admin\",\n        \"profession\": \"管理员\",\n        \"userimg\": null,\n        \"encrypt\": \"67f88b\",\n        \"password\": \"148ae4c922bc4d5ae4126f65cd268478\",\n        \"changepass\": 0,\n        \"login_num\": 1,\n        \"last_ip\": \"117.181.99.49\",\n        \"last_at\": 1712598269000,\n        \"line_ip\": \"117.181.99.49\",\n        \"line_at\": 1712598269000,\n        \"task_dialog_id\": 18,\n        \"created_ip\": \"\",\n        \"disable_at\": null,\n        \"email_verity\": true,\n        \"bot\": 0,\n        \"created_at\": \"2024-03-06 21:13:04\",\n        \"updated_at\": 1709798907000,\n        \"nickname_original\": \"\",\n        \"department_name\": \"\",\n        \"department_owner\": \"\"\n    },\n    \"timestamp\": 1712598417183,\n    \"executeTime\": 3\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import 'cn.dev33.satoken.stp.StpUtil';
import log


if (!StpUtil.isLogin()) {
    exit - 1, "请登录后继续...";
}

var userid = StpUtil.getLoginId()
log.info("userids is-->" + userids)

//TODO 移动端token还剩7天到期时获取新的token

var user = db.table("users").where().eq("userid", userid).selectOne()
user.nickname_original = ''
user.department_name = ''
user.department_owner = ''
///判断是否是管理员
if (user.identity != null && user.identity.length() > 0) {
    user.identity = user.identity.split(',');
}

log.info("user-->" + user)
return user