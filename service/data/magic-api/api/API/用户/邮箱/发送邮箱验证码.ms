{
  "properties" : { },
  "id" : "aa142860164849e487d834651cb9482a",
  "script" : null,
  "groupId" : "5b45cadb3b994384a354e61195f34f2e",
  "name" : "发送邮箱验证码",
  "createTime" : 1716867158243,
  "updateTime" : 1713024591472,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "send",
  "method" : "GET",
  "parameters" : [ {
    "name" : "type",
    "value" : null,
    "description" : "邮件类型",
    "required" : false,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "email",
    "value" : null,
    "description" : "邮箱地址",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : "请输入新邮箱地址",
    "expression" : "value.length()>0",
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 400,\n    \"message\": \"请输入新邮箱地址\",\n    \"data\": null,\n    \"timestamp\": 1708496610762,\n    \"executeTime\": 1\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
//判断是否是正常的邮箱地址
//不能与旧邮箱一致
//与当前登录邮箱不一致
//邮箱地址已存在
//发送邮箱验证码
return 'Hello magic-api'