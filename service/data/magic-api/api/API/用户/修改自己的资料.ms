{
  "properties" : { },
  "id" : "5a9452fa68994a2e8706f8ffffdadbd1",
  "script" : null,
  "groupId" : "731c0f0eb0fd4dd792004009271d66fa",
  "name" : "修改自己的资料",
  "createTime" : 1717060653346,
  "updateTime" : 1713325121898,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "editdata",
  "method" : "GET",
  "parameters" : [ {
    "name" : "tel",
    "value" : "18681529205",
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
    "name" : "nickname",
    "value" : "昵称",
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
    "name" : "profession",
    "value" : "职位/职称",
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
    "name" : "userimg",
    "value" : "会员头像（地址）",
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
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import 'cn.dev33.satoken.stp.StpUtil';
import log

var userid = StpUtil.getLoginId()
log.info("userids is-->" + userids)

var builder = db.table("users").primary("id")
var data = {}

user = db.table("users").where().eq("id", userid).selectOne()

//TODO 用户头像的更改
if (tel != null) {
    if (tel.getLength() < 6 || tel.getLength() > 20) {
        exit 400, '联系电话长度错误';
    }
    if (user.mobile == tel) {
        exit 400, '联系电话已存在';
    }
    data.tel = tel
}
if (nickname != null) {
    if (nickname.getLength() < 2) {
        exit 400, '昵称不可以少于2个字';
    }
    if (nickname.getLength() > 20) {
        exit 400, '昵称最多只能设置20个字';
    }
    //  $user->az = Base::getFirstCharter($nickname);
    //  $user->pinyin = Base::cn2pinyin($nickname);
    //TODO 首写字母
    data.az = ''
    // TODO 拼音
    data.pinyin = ''

    data.nickname = nickname
}
if (profession != null) {
    if (profession.getLength() < 2) {
        exit 400, '职位/职称不可以少于2个字';
    }
    if (profession.getLength() > 20) {
        exit 400, '职位/职称最多只能设置20个字';
    }
    data.profession = profession
}



user = db.table("users").where().eq("id", userid).selectOne()
//生成新的token
var token = StpUtil.getTokenValueByLoginId(user.userid)
user.token = token

if (use != null) {
    return user
}

//生成新的token



exit 400, '修改错误';