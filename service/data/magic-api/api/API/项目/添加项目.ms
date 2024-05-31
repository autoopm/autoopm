{
  "properties" : { },
  "id" : "132df1e24b504aef807c77e5e67c1020",
  "script" : null,
  "groupId" : "0c2d9f4051a44b37a9a0f361f4e13b75",
  "name" : "添加项目",
  "createTime" : 1717060653745,
  "updateTime" : 1716877420526,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/add",
  "method" : "GET",
  "parameters" : [ {
    "name" : "name",
    "value" : "12331212",
    "description" : null,
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "pass",
    "error" : "项目名称不能少于2个字",
    "expression" : "",
    "children" : null
  }, {
    "name" : "desc",
    "value" : null,
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : "项目介绍最多只能设置255个字",
    "expression" : "value.length()>255",
    "children" : null
  }, {
    "name" : "columns",
    "value" : "",
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
    "name" : "flow",
    "value" : "open",
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
    "name" : "personal",
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
  "headers" : [ {
    "name" : "token",
    "value" : "2119d6a4-79bf-4fee-b0d7-e4677d1f7657",
    "description" : null,
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 500,\n    \"message\": \"系统内部出现错误\",\n    \"data\": null,\n    \"timestamp\": 1711609127547,\n    \"executeTime\": 45\n}",
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
      "value" : "1711608941416",
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
      "value" : "17",
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
import 'cn.dev33.satoken.stp.StpUtil';
import log
import cn.hutool.core.util.IdUtil;
import http;
import '@/project/addFlow' as addFlow;
import env

var wukongIMUrl = env.get("wukongim.endpoint")
log.info("wukongIMUrl" + wukongIMUrl);


if (name.length() > 32) {
    exit 400, '项目名称最多设置32个字符'
}

let insertColumns = [];
//分割列表
if (columns != "") {
    let columnsArr = columns.split(',');
    let insertColumns = [];
    let sort = 0;
    //创建列表参数 排序
    for (item in columnsArr) {
        insertColumns.push({
            'name': item.trim(),
            'sort': sort++
        })
    }
} else {
    log.info('--------------->columns无值:' + columns)
}
if (insertColumns.size() == 0) {
    insertColumns.push({
        'name': 'Default',
        'sort': 0
    })
}

//限制列表数量不超过30个
if (insertColumns.size() > 30) {
    exit 400, '项目列表最多不能超过30个'
}

var project
var projectId
//判断个人项目是否已经存在
var userid = StpUtil.getLoginId()
// var userid = 6  //测试时候放开
if (personal) {
    project = db.table("projects").where().eq("userid", userid).eq("personal", 1) selectOne()
    log.info("person project is.  " + project)
    if (project.size() > 0) {
        exit 400, '个人项目已存在，无须重复创建'
    }
    //返回的project中personal赋值1
    project.personal = 1
}



//启动事务
var val = db.transaction(() => {
    // 创建频道，并将自己加入
    let subscribers = []
    var useridStr = userid::string
    subscribers.push(useridStr)
    channelId = IdUtil.simpleUUID() //频道id
    var responseEntity = http.connect(wukongIMUrl+'/channel').contentType('application/json').body({
        channel_id: channelId, // 频道的唯一ID，如果是群聊频道，建议使用群聊ID
        channel_type: 2, // 频道的类型 1.个人频道 2.群聊频道（个人与个人聊天不需要创建频道，系统将自动创建）
        large: 0, // 是否是超大群，0.否 1.是 （一般建议500成员以上设置为超大群，注意：超大群不会维护最近会话数据。）
        ban: 0, // 是否封禁此频道，0.否 1.是 （被封后 任何人都不能发消息，包括创建者）
        subscribers: subscribers, // 设// 订阅者集合
    }).post().getBody();

    log.info("加入频道返回responseEntity" + responseEntity)



    if (responseEntity.status == 200) {
        log.info("创建频道成功")
    } else {
        log.info("创建频道失败")
        exit 400, "创建频道失败";
    }

    //插入dialog表
    dialog = db.table("web_socket_dialogs").insert({
        name: name,
        type:"group",
        group_type:"project",
        channel_id: channelId,  
    })
    
    //创建项目  
    projectId = db.table('projects').insert({
        name: name,
        desc: desc,
        userid: userid,
        dialog_id: channelId,  //这里改成了频道id，web_socket_dialogs 这是记录相应的信息
    })
    log.info("创建项目返回-->" + projectId)


    //插入项目用户表 
    var projectuser = db.table('project_users').insert({
        project_id: projectId,
        userid: userid,
        owner: userid
    })
    //插入项目列表，遍历插入
    for (index, item in insertColumns) {
        var project_columns = db.table('project_columns').insert({
            name: item.name,
            sort: item.sort,
            project_id: projectId
        })
    }
    //创建工作流
    if (flow == 'open') {
        //默认的工作流配置
        var flows = [{
            "id": -10,
            "name": "待处理",
            "status": "start",
            "turns": [-10, -11, -12, -13, -14],
            "userids": "[]",
            "usertype": "add",
            "userlimit": 0,
            "columnid": 0
        }, {
            "id": -11,
            "name": "进行中",
            "status": "progress",
            "turns": [-10, -11, -12, -13, -14],
            "userids": "[]",
            "usertype": "add",
            "userlimit": 0,
            "columnid": 0
        }, {
            "id": -12,
            "name": "待测试",
            "status": "test",
            "turns": [-10, -11, -12, -13, -14],
            "userids": "[]",
            "usertype": "add",
            "userlimit": 0,
            "columnid": 0
        }, {
            "id": -13,
            "name": "已完成",
            "status": "end",
            "turns": [-10, -11, -12, -13, -14],
            "userids": "[]",
            "usertype": "add",
            "userlimit": 0,
            "columnid": 0
        }, {
            "id": -14,
            "name": "已取消",
            "status": "end",
            "turns": [-10, -11, -12, -13, -14],
            "userids": "[]",
            "usertype": "add",
            "userlimit": 0,
            "columnid": 0
        }]
        //执行流程创建
        log.info("执行流程创建。。。")
        var projectFlowList =  addFlow(flows,projectId)
         log.info("执行流程创建结束。。。")
    }
});

//查找project
project = db.table("projects").where().eq("id", projectId).selectOne()

//创建项目日志
var logDetail = '创建项目'
var project_log = db.table('project_logs').insert({
    project_id: projectId,
    column_id: 0,
    task_id: 0,
    userid: userid,
    detail: logDetail
})
//TODO 推送创建项目信息，后面再做
return project