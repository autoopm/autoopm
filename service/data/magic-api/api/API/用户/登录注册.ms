{
  "properties" : { },
  "id" : "55130f4531c44b069a2671e7c5565caa",
  "script" : null,
  "groupId" : "731c0f0eb0fd4dd792004009271d66fa",
  "name" : "登录注册",
  "createTime" : null,
  "updateTime" : 1717060780426,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/login",
  "method" : "GET",
  "parameters" : [ {
    "name" : "type",
    "value" : "login",
    "description" : null,
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "login",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "email",
    "value" : "admin@autoo.com",
    "description" : null,
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "password",
    "value" : "123456",
    "description" : null,
    "required" : true,
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
  }, {
    "name" : "code_key",
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
    "name" : "invite",
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
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"userid\": 6,\n        \"identity\": \",admin,\",\n        \"department\": \"\",\n        \"az\": \"A\",\n        \"pinyin\": \"\",\n        \"email\": \"admin@autoo.com\",\n        \"tel\": \"\",\n        \"nickname\": \"Admin\",\n        \"profession\": \"管理员\",\n        \"userimg\": null,\n        \"encrypt\": \"67f88b\",\n        \"password\": \"\",\n        \"changepass\": 0,\n        \"login_num\": 1,\n        \"last_ip\": \"117.181.99.48\",\n        \"last_at\": 1711729907000,\n        \"line_ip\": \"117.181.99.48\",\n        \"line_at\": 1711729907000,\n        \"task_dialog_id\": 18,\n        \"created_ip\": \"\",\n        \"disable_at\": null,\n        \"email_verity\": true,\n        \"bot\": 0,\n        \"created_at\": \"2024-03-06 21:13:04\",\n        \"updated_at\": 1709798907000,\n        \"token\": \"b31bd89a-f54c-439b-a90c-3246489d4796\"\n    },\n    \"timestamp\": 1711912715901,\n    \"executeTime\": 336\n}",
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
      "name" : "type",
      "value" : "login",
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
      "name" : "email",
      "value" : "admin@autoo.com",
      "description" : "",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "expression",
      "error" : "账号最多可输入32位字符",
      "expression" : "value.length()<32",
      "children" : [ ]
    }, {
      "name" : "password",
      "value" : "8d95ebceaaeb2f95",
      "description" : "",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "expression",
      "error" : "密码最多可输入32位字符",
      "expression" : "value.length()<32",
      "children" : [ ]
    }, {
      "name" : "code",
      "value" : "12331",
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
      "name" : "code_key",
      "value" : "12331",
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
      "name" : "invite",
      "value" : "10086",
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
      "value" : "500",
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
      "value" : "系统内部出现错误",
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
      "value" : "1711101117825",
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
      "value" : "45",
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
import cn.hutool.core.util.StrUtil
import cn.hutool.core.util.RandomUtil
import cn.hutool.core.util.ReUtil;
import log
import 'cn.dev33.satoken.secure.SaSecureUtil';
import 'cn.dev33.satoken.stp.StpUtil';
import 'cn.hutool.core.lang.Validator';
import 'cn.hutool.core.util.StrUtil';
import 'cn.hutool.extra.pinyin.PinyinUtil';
import env;
import request;
import http;
import org.ssssssss.magicboot.utils.MinioUtil;

//登录的时候检测
var bucketName = env.get('minio.bucketName')
log.info("env bucketName-->" + bucketName)
MinioUtil.checkBucket(bucketName)

var user
log.info("type is" + type)



if (type == 'reg') {
    log.info("注册逻辑")
    var system = db.table("settings").where().eq("name", "system").selectOne()
    log.info('system value ' + system)
    //TODO 默认都给注册
    if (system != null) {
        var result = system.setting::json
        log.info('system value result ' + result)
        // if (result == null) {
        //     exit 400, '未开放注册';
        // }

        // regSetting = result.reg || 'open'
        // if (regSetting == 'close') {
        //     exit 400, '未开放注册';
        // }
        // 邀请流程先不考虑
        //验证邮箱环节先不考虑
    }
    if (!Validator.isEmail(email)) {
        exit 400, '请输入正确的邮箱地址';

    } else {
        log.info("邮箱地址正确")
    }

    userInfo = db.table("users").where().eq("email", email).selectOne()
    log.info("userInfo" + userInfo)
    if (userInfo != null) {
        exit 400, '用户已存在';
    }

    encrypt = RandomUtil.randomString(6)
    pwd = SaSecureUtil.md5(SaSecureUtil.md5(password) + encrypt)

    before = StrUtil.subBefore(email, "@", false)
    log.info("before-->" + before)
    pinyin = before //获取纯字母部分
    log.info("pinyin-->" + pinyin)
    az = StrUtil.upperFirst(pinyin.substring(0, 1))
    nickname = pinyin

    result = db.table("users").insert({
        email: email,
        encrypt: encrypt,
        Password: pwd,
        // pinyin:pinyin, //暂时先不管
        az: az,
        nickname,
        nickname,
    })

    //加入全员群组
    // 设置不为机器人

    userInfo = db.table("users").where().eq("email", email).selectOne()
    log.info("添加后userInfo" + userInfo)
    return userInfo
    //获取系统设置，判断是否开启注册，如果开启邀请码方式则验证邀请码是否正确
    //执行用户注册(加入全员群组)

    // PinyinUtil.getPinyin()

    // az
    //  pinyin
    //  created_ip
    //判断是否需要验证邮箱，如果需要则需要进入邮箱激活
} else {
    log.info("登录逻辑")
    //检查文件并创建桶

    //位数限制

    //判断是否需要显示验证码，如果需要，则需要去验证
    //判断账号是否被停用
    //判断系统设置是否需要验证邮箱，如果需要则提示验证去验证邮箱 
    //获取登录的ip 和当前的当前的时间
    userInfo = db.table("users").where().eq("email", email).selectOne()
    if (userInfo == null) {
        exit 400, '用户不存在';
    }
    log.info("userInfo---->" + userInfo)
    log.info("userInfo.encrypt---->" + userInfo.encrypt)
    pwd = SaSecureUtil.md5(SaSecureUtil.md5(password) + userInfo.encrypt)
    if (userInfo.password != pwd) {
        exit 0, '用户名或密码错误'
    }
    //更新用户id和最后登录时间
    ip = request.getClientIP()
    var data = {
        userid,
        login_num,
        last_ip,
        last_at,
        line_ip,
        line_at,
    }

    data.userid = userInfo.userid
    data.login_num = (userInfo.loginNum ? userInfo.loginNum : 0) + 1
    data.last_ip = ip
    data.last_at = now()
    data.line_ip = ip
    data.line_at = now()
    db.table('users').primary('userid').update(data, true)


    // var token = StpUtil.login(user.userid) 

    // var token = StpUtil.getTokenValueByLoginId(user.userid)
    // log.info("token-->"+token)
    // log.info("user：-->"+user)
    // return user

    StpUtil.login(userInfo.userid)
    var token = StpUtil.getTokenValueByLoginId(userInfo.userid)
    userInfo.token = token
    let useridStr = userInfo.userid::string
    log.info("userid" + useridStr)
    // loginLog.token = token
    // db.table("sys_login_log").primary("id").save(loginLog);
    // CodeCacheMap.remove(body.uuid)
    // return StpUtil.getTokenValueByLoginId(user.id)

    //TODO 执行悟空IM用户注册登录，只有登录才会执行
    var wukongIMUrl = env.get("wukongim.endpoint")
    log.info("wukongIMUrl" + wukongIMUrl);
    var responseEntity = http.connect(wukongIMUrl + '/user/token').contentType('application/json').body({
        uid: useridStr, // 通信的用户唯一ID，可以随机uuid （建议自己服务端的用户唯一uid） （WuKongIMSDK需要）
        token: token, // 校验的token，随机uuid（建议使用自己服务端的用户的token）（WuKongIMSDK需要）
        device_flag: 1, // 设备标识  0.app 1.web （相同用户相同设备标记的主设备登录会互相踢，从设备将共存）
        device_level: 1, // 设备等级 0.为从设备 1.为主设备
    }).post().getBody();
    log.info("执行悟空IM用户登录" + responseEntity)


    // userInfo = db.table("users").columns("").where().eq("column",userInfo.userid).selectOne()
    //TODO 要去除密码等字段
    userInfo.password = ""


    var bucketName = env.get('minio.bucketName')
    log.info("env bucketName-->" + bucketName)
    MinioUtil.checkBucket(bucketName)

    return userInfo
}

// return user