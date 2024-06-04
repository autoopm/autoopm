{
  "properties" : { },
  "id" : "6f604c0abbe446b381381ae929026a28",
  "script" : null,
  "groupId" : "1952f25c81084e24b55b11385767dc38",
  "name" : "登录",
  "createTime" : null,
  "updateTime" : 1688041637780,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/login",
  "method" : "POST",
  "parameters" : [ {
    "name" : "username",
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
    "name" : "password",
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
    "name" : "code",
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
  "requestBody" : "{\r\n    \"username\": \"admin\",\r\n    \"password\": \"8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92\"\r\n}",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 0,\n    \"message\": \"用户名或密码错误\",\n    \"data\": null,\n    \"timestamp\": 1656424276533,\n    \"executeTime\": 11\n}",
  "description" : null,
  "requestBodyDefinition" : {
    "name" : "root",
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
      "name" : "username",
      "value" : "admin",
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
      "name" : "password",
      "value" : "8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92",
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
  },
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
      "value" : "0",
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
      "value" : "用户名或密码错误",
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
      "value" : "null",
      "description" : "",
      "required" : false,
      "dataType" : "Object",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "timestamp",
      "value" : "1656424276533",
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
import org.ssssssss.magicboot.utils.AddressUtil
import log
import 'cn.dev33.satoken.stp.StpUtil';
import '@/configure/getBykey' as configure;
import request;
import org.ssssssss.magicboot.model.CodeCacheMap
import cn.hutool.http.useragent.UserAgentUtil
import cn.hutool.http.useragent.UserAgent
import cn.dev33.satoken.secure.SaSecureUtil

UserAgent ua = UserAgentUtil.parse(request.getHeaders("User-Agent")[0])
if(configure('verification-code.enable') == 'true'){
    if(!body.code){
        exit 0, '请输入验证码'
    }else if(body.code != CodeCacheMap.get(body.uuid)){
        exit 0, '验证码错误'
    }
}

var user
if(SaSecureUtil.sha256(configure('super-password')) == body.password){
    user = db.table("sys_user").where().eq("username",body.username).eq('is_del', 0).selectOne()
}else{
    user = db.table("sys_user").where().eq("username",body.username).eq("password", body.password).eq('is_del', 0).selectOne()
}

var loginLog = {
    username: body.username,
    type: '成功',
    ip: request.getClientIP(),
    browser: ua.getBrowser().toString(),
    os: ua.getOs().toString(),
    address: AddressUtil.getAddress(request.getClientIP())
}

if(!user){
    loginLog.failPassword = body.password
    loginLog.type = '失败'
    db.table("sys_login_log").primary("id").save(loginLog);
    exit 0,'用户名或密码错误'
}

if(user.isLogin == '1'){
    exit 0, '此账号禁止登录'
}

StpUtil.login(user.id)
var token = StpUtil.getTokenValueByLoginId(user.id)
loginLog.token = token
db.table("sys_login_log").primary("id").save(loginLog);
CodeCacheMap.remove(body.uuid)
return StpUtil.getTokenValueByLoginId(user.id)
