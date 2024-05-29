{
  "properties" : { },
  "id" : "4ce483fbf60b4aeab2cb70df7f835a37",
  "script" : null,
  "groupId" : "731c0f0eb0fd4dd792004009271d66fa",
  "name" : "操作会员(管理员)",
  "createTime" : 1716867157884,
  "updateTime" : 1713325126815,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/operation",
  "method" : "GET",
  "parameters" : [ {
    "name" : "userid",
    "value" : "1",
    "description" : "会员ID",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "type",
    "value" : "setadmin",
    "description" : "操作",
    "required" : false,
    "dataType" : "String",
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
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "tel",
    "value" : null,
    "description" : "联系电话",
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
    "description" : "新的密码",
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
    "value" : null,
    "description" : "昵称",
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
    "value" : null,
    "description" : "职位",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "checkin_macs",
    "value" : null,
    "description" : "自动签到mac地址",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "department",
    "value" : null,
    "description" : "部门",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "disable_time",
    "value" : null,
    "description" : "离职时间",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "transfer_userid",
    "value" : null,
    "description" : "离职交接人",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "delete_reason",
    "value" : null,
    "description" : "删除原因",
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
  "responseBody" : "{\n    \"code\": 400,\n    \"message\": \"已经是管理员\",\n    \"data\": null,\n    \"timestamp\": 1708613909117,\n    \"executeTime\": 13\n}",
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
      "value" : "1708613555723",
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
// type：
// setadmin 设为管理员
// clearadmin 取消管理员
// settemp 设为临时帐号
// cleartemp 取消临时身份（取消临时帐号）
// checkin_macs 修改自动签到mac地址（需要参数 checkin_macs）
// department 修改部门（需要参数 department）
// setdisable 设为离职（需要参数 disable_time、transfer_userid）
// cleardisable 取消离职
// delete 删除会员（需要参数 delete_reason）
import log

import 'cn.dev33.satoken.stp.StpUtil';
import log


//判断个人项目是否已经存在
var loginUserid = StpUtil.getLoginId()
log.info("loginUserid is" + loginUserid)

userInfo = db.table("users").where().eq("userid", userid).selectOne()
if (userInfo == null) {
    exit 400, '成员不存在或已被删除';
}
if (type != null) {
    if (type == "setadmin") { //设置为管理员
        log.info("userInfo" + userInfo)
        log.info("userInfo.identity" + userInfo.identity)
        if (userInfo.identity != null) {
            log.info("userInfo" + userInfo)
            let identityArr = userInfo.identity.split(',');
            for (item in identityArr) {
                log.info("identityArr item " + item)
            }

            if (identityArr.some(ident => ident === 'admin')) {
                log.info("包含admin ")
                exit 400, '已经是管理员'
            } else {
                log.info("不包含admin")
            }
            //TODO 判断原来有没有admin
            //如果有就直接返回
            //如果没有就添加 
            db.table("users").primary("userid").update({
                userid: userid,
                identity: (userInfo.identity ? userInfo.identity : ",") + 'admin,' //没有则在后面添加
            })
        } else {
            //为空的情况下直接添加
            log.info("userInfo 用户权限为空")
            db.table("users").primary("userid").update({
                userid: userid,
                identity: (userInfo.identity ? userInfo.identity : ",") + 'admin,' //没有则在后面添加
            })
        }
        return '收到设置为管理员指令'
    } else if (type == "department") { //修改的部门
        //判断最多加入10个部门
        let departmentArr = department.split(',');
        if (departmentArr.size() > 10) {
            exit 400, '最多只可加入10个部门';
        }
        //查找部门是否存在
        for (item in departmentArr) {
            result = db.table("user_departments").where().eq("id", item).selectOne()
            if (result == null) {
                exit 400, '修改部门不存在';
            }
        }
        db.table("users").primary("userid").update({
            userid: userInfo.userid,
            department: department,
        })
        return "修改部门成功"

    } else if (type == "clearadmin") {
        log.info("userInfo" + userInfo)
        log.info("userInfo.identity" + userInfo.identity)
        if (userInfo.identity != null) {
            log.info("userInfo" + userInfo)
            let identityArr = userInfo.identity.split(',');
            for (item in identityArr) {
                log.info("identityArr item " + item)
            }
            //如果是管理员就删除
            if (identityArr.some(ident => ident === 'admin')) {
                log.info("包含admin ")
                //如果有就删除
                db.table("users").primary("userid").update({
                    userid: userid,
                    identity: userInfo.identity.replace('admin,', '')
                })
                return '收到取消管理员指令'
            } else {
                log.info("不包含admin")
                exit 400, '会员不是管理员，操作失败';
            }
        } else {
            log.info("userInfo 用户权限为空")
            exit 400, '会员不是管理员，操作失败';
        }
    } else if (type == "setdisable") { //设为离职
        //判断是否是自己
        if (loginUserid == userInfo.userid) {
            exit 400, '不能操作自己离职';
        }
        //
        db.table("users").primary("userid").update({
            userid: userInfo.userid,
            identity: (userInfo.identity ? userInfo.identity : ",") + 'disable,', //没有则在后面添加
            disable_at: disable_time //离职时间设为当前
        }, true)

    } else if (type == "cleardisable") { //取消离职
        db.table("users").primary("userid").update({
            userid: userInfo.userid,
            identity: userInfo.identity.replace('disable,', ''),
            disable_at: "" //离职时间设为空
        }, true)

    } else if (type == "delete") { //删除
        //判断是否是自己
        if (loginUserid == userInfo.userid) {
            exit 400, '不能删除自己';
        }
        //判断原因是否为空
        if (delete_reason == null) {
            exit 400, '请填写删除原因';
        }
        //删除用户的操作

        // 删除原因
        db.table("user_deletes").insert({
            operator: loginUserid,
            userid: userid,
            email: userInfo.email,
            reason: delete_reason,
            cache: "", //TODO 未完成
        })

        // 删除未读
        // 删除待办
        // 删除邮箱验证记录
        // 删除用户
        db.table("user_deletes").primary("userid").update({
            userid: userInfo.userid
        })
        result = db.table("user_deletes").where().eq("userid", userInfo.userid).delete()
        log.info("delete user result is " + result)

    } else { //TODO 设置和取消临时用户先不管
        return '其他指令未支持'
    }

}

//TODO 设置权限





// db.table("users").primary("userid").update({
//     userid: userInfo.userid,
//     department: '',
// })

if (email != null) {
    users = db.table("users").where().eq("email", email).notLike("userid", loginUserid).select()
    if (users.size() > 0) {
        exit 400, '邮箱已存在';
    }

    db.table("users").primary("userid").update({
        userid: userInfo.userid,
        email: email,
    })
}

if (tel != null) {
    //判断电话是否已经存在
    users = db.table("users").where().eq("tel", tel).notLike("userid", loginUserid).select()
    if (users.size() > 0) {
        exit 400, '联系电话已存在';

    }
    db.table("users").primary("userid").update({
        userid: userInfo.userid,
        tel: tel,
    })
}

if (password != null) { //修改密码
    db.table("users").primary("userid").update({
        userid: userInfo.userid,
        encrypt: '6', //盐，随机6位数
        password: '', //新升成的密码
        changepass: 1
    })
}

if (nickname != null) { //修改昵称

    if (nickname.length() < 2) {
        exit 400, '昵称不可以少于2个字';
    }

    if (nickname.length() > 20) {
        exit 400, '昵称最多只能设置20个字';

    }
    db.table("users").primary("userid").update({
        userid: userInfo.userid,
        nickname: nickname, ///修改昵称
        az: '',
        pinyin: '',
    })
}

if (profession != null) { //职位/职称
    if (profession.length() < 2) {
        exit 400, '职位/职称不可以少于2个字';
    }

    if (profession.length() > 20) {
        exit 400, ' 职位/职称最多只能设置20个字';

    }
    db.table("users").primary("userid").update({
        userid: userInfo.userid,
        profession: profession, //职位/职称
    })
}

// 取消离职重新加入全员群组