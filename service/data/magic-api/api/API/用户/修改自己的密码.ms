{
  "properties" : { },
  "id" : "36a61e05ad9e47d2b7d348c564123c66",
  "script" : null,
  "groupId" : "731c0f0eb0fd4dd792004009271d66fa",
  "name" : "修改自己的密码",
  "createTime" : 1717060653342,
  "updateTime" : 1713325119691,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/editpass",
  "method" : "GET",
  "parameters" : [ {
    "name" : "oldpass",
    "value" : "d5073d1ab6e1a1e5",
    "description" : "旧密码",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "newpass",
    "value" : "123456",
    "description" : "新密码",
    "required" : true,
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
  "headers" : [ {
    "name" : "token",
    "value" : "4e372647-874d-4421-90d7-0913fefec368",
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
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 500,\n    \"message\": \"系统内部出现错误\",\n    \"data\": null,\n    \"timestamp\": 1711455078427,\n    \"executeTime\": 9\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import 'cn.dev33.satoken.stp.StpUtil';
import log
import 'cn.dev33.satoken.secure.SaSecureUtil';

var userid = StpUtil.getLoginId()
log.info("userids is-->" + userids)

if (oldpass == newpass) {
    exit 400, '新旧密码一致';
}
//检查密码的策略
//验证旧密码
// var oldPwd = oldpass

user = db.table("users").where().eq("userid", userid).selectOne()
if (user == null) {
    exit 400, "用户不存在";
}

encrypt = user.encrypt
oldPwd = SaSecureUtil.md5(SaSecureUtil.md5(oldpass) + encrypt)

result = db.table("users").where().eq("userid", userid).eq("password", oldPwd).selectOne()
if (result == null) {
    exit 400, '请填写正确的旧密码';
}

//生成新密码
newpwd = SaSecureUtil.md5(SaSecureUtil.md5(newpass) + encrypt)
//更新新密码
result = db.table("users").primary("userid").update({
    userid: userid,
    password: newpwd,
    changepass:0
})

//刷新 token 暂时不考虑

user = db.table("users").where().eq("userid", userid).selectOne()
// StpUtil.login(userInfo.userid)
// var token = StpUtil.getTokenValueByLoginId(userInfo.userid)
return  user