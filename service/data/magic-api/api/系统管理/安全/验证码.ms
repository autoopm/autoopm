{
  "properties" : { },
  "id" : "be89865140ab409085db6d0cc6d82452",
  "script" : null,
  "groupId" : "1952f25c81084e24b55b11385767dc38",
  "name" : "验证码",
  "createTime" : null,
  "updateTime" : 1647333578623,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/verification/code",
  "method" : "GET",
  "parameters" : [ ],
  "options" : [ {
    "name" : "require_login",
    "value" : "false",
    "description" : "该接口需要登录才允许访问",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"img\": \"data:image/png;base64,[B@65617f6d\",\n        \"uuid\": \"9a080e570e0346bf8b80c035c977c888\"\n    },\n    \"timestamp\": 1647333558240,\n    \"executeTime\": 15\n}",
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
        "name" : "img",
        "value" : "data:image/png;base64,[B@65617f6d",
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
        "name" : "uuid",
        "value" : "9a080e570e0346bf8b80c035c977c888",
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
      "value" : "1647333558240",
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
      "value" : "15",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
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
import cn.hutool.captcha.LineCaptcha
import cn.hutool.captcha.CaptchaUtil
import log
import java.io.ByteArrayOutputStream
import java.io.OutputStream
import org.ssssssss.magicboot.model.CodeCacheMap

LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(100, 48);
var uuid = UUID.randomUUID().toString().replace('-', '')
CodeCacheMap.put(uuid, lineCaptcha.getCode())
OutputStream bOut = new ByteArrayOutputStream();
lineCaptcha.write(bOut)
var bytes = bOut.toByteArray()
return {
    img: bytes,
    uuid: uuid
}