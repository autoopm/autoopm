{
  "properties" : { },
  "id" : "copy1706327758311d38348",
  "script" : null,
  "groupId" : "f2a82a98ff1d49a3904430542a3d776d",
  "name" : "添加任务(get方法)-完善中",
  "createTime" : null,
  "updateTime" : 1716877593713,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/add",
  "method" : "GET",
  "parameters" : [ {
    "name" : "cascader",
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
    "name" : "name",
    "value" : "123123",
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
    "name" : "content",
    "value" : "",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "owner",
    "value" : "1",
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
    "name" : "assist",
    "value" : "",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "project_id",
    "value" : "29",
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
    "name" : "column_id",
    "value" : "59",
    "description" : null,
    "required" : false,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "times",
    "value" : "2024-02-27 11:08:08,2024-02-28 11:08:08",
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
    "name" : "subtasks",
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
    "name" : "p_level",
    "value" : "1",
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
    "name" : "p_name",
    "value" : "重要且紧急",
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
    "name" : "p_color",
    "value" : "#ED4014",
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
    "name" : "visibility_appoint",
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
    "name" : "visibility_appointor",
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
    "name" : "top",
    "value" : "0",
    "description" : "添加的任务排到列表最前面",
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
    "value" : "544fe5f6-99c6-4b6f-8cbe-0188b4b82c18",
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
  "responseBody" : "{\n    \"code\": 500,\n    \"message\": \"系统内部出现错误\",\n    \"data\": null,\n    \"timestamp\": 1711017913618,\n    \"executeTime\": 13\n}",
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
      "name" : "cascader",
      "value" : "",
      "description" : "",
      "required" : false,
      "dataType" : "Array",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ {
        "name" : "",
        "value" : "84",
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
    }, {
      "name" : "name",
      "value" : "12313",
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
      "name" : "content",
      "value" : "<p>31313</p>",
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
      "name" : "owner",
      "value" : "",
      "description" : "",
      "required" : false,
      "dataType" : "Array",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ {
        "name" : "",
        "value" : "1",
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
    }, {
      "name" : "assist",
      "value" : "",
      "description" : "",
      "required" : false,
      "dataType" : "Array",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "project_id",
      "value" : "84",
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
      "name" : "column_id",
      "value" : "181",
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
      "name" : "times",
      "value" : "",
      "description" : "",
      "required" : false,
      "dataType" : "Array",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ {
        "name" : "",
        "value" : "2024-01-27 09:00",
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
      "name" : "subtasks",
      "value" : "",
      "description" : "",
      "required" : false,
      "dataType" : "Array",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "p_level",
      "value" : "1",
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
      "name" : "p_name",
      "value" : "重要且紧急",
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
      "name" : "p_color",
      "value" : "#ED4014",
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
      "name" : "visibility_appoint",
      "value" : "1",
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
      "name" : "visibility_appointor",
      "value" : "",
      "description" : "",
      "required" : false,
      "dataType" : "Array",
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
      "value" : "1711017691614",
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
      "value" : "5",
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
import cn.hutool.core.util.ReUtil
import 'cn.dev33.satoken.stp.StpUtil';
import log
import '@/project/use' as use

import 'cn.hutool.core.util.ReUtil';
import 'cn.hutool.core.date.DateUtil';
import 'cn.hutool.core.io.FileUtil';
import 'cn.hutool.core.io.IoUtil';
import 'cn.hutool.core.util.StrUtil';
import 'cn.hutool.http.HttpUtil';
import env

var wukongIMUrl = env.get("wukongim.endpoint")
log.info("wukongIMUrl" + wukongIMUrl);


//判断个人项目是否已经存在
var userid = StpUtil.getLoginId()
log.info("userid is" + userid)

var projectId = project_id
var columnId = column_id

//判断项目是否已归档，自己在不在项目中
var useProject = db.table("projects").where().eq("id", projectId).notNull("archived_at").selectOne()
if (useProject == null) {
    exit 400, '项目不存在或已归档'
}

if (name.length() == 0) {
    exit 400, '描述不能为空'
}

var column
var newColumn
//获取列表对应的列表信息
if (columnId) {
    log.info('进到这里column_id：' + columnId);
    if (columnId > 0) {
        //从项目任务列表中找到那个列表
        column = db.table("project_columns").where().eq("project_id", projectId).eq("id", columnId).selectOne()
    }
    //如果还是找不到列表，试着用column_id作为名字去查找
    if (column == null) {
        column = db.table("project_columns").where().eq("project_id", projectId).eq("name", columnId).selectOne()
    }
} else {
    //如果没有则使用第一个任务列表
    column = db.table("project_columns").where().eq("project_id", projectId).orderBy("id").selectOne()
}
//如果再没有则创建新的
if (column == null) {
    log.info('column is null')
    var tempColumnName
    if (columnId == null) {
        tempColumnName = 'Default'
    }
    sort = 0
    //设置排序
    var columnResult = db.table("project_columns").where().eq("id", projectId).orderByDesc('sort').selectOne()
    if (columnResult != null) {
        sort = columnResult.sort + 1
        log.info('sort is' + sort)
    }
    var result = db.table('project_columns').insert({
        project_id: projectId,
        name: tempColumnName,
        sort: sort,
    })
    log.info('插入任务列表的结果：' + result)
    //创建创建列表日志
    var logDetail = '创建列表' + tempColumnName
    var project_log = db.table('project_logs').insert({
        project_id: projectId,
        column_id: 0,
        task_id: 0,
        userid: userid,
        detail: logDetail
    })
    newColumn = db.table("project_columns").where().eq("id", result).selectOne()
    newColumn.project_task = []
}
if (newColumn = null) {
    exit 400, '任务列表不存在或已被删除'
}


var flowItemId
var flowItemName

//工作流处理
var projectFlow = db.table("project_flows").where().eq("project_id", projectId).selectOne()
log.info('projectFlow:' + projectFlow)


if (projectFlow != null) { //开启工作流的项目
    var projectFlowItem = db.table("project_flow_items").where().eq("flow_id", projectFlow.id).select()
    log.info('projectFlowItem:' + projectFlowItem)
    //赋开始状态
    for (item in projectFlowItem) {
        if (item.status == 'start') {
            flowItemId = item.id
            flowItemName = item.status + '|' + item.name
        }
    }
} else { //未开始工作流的项目


}

//TODO 项目内未完成任务不能超过2000个
tasks = db.table("project_tasks").where().eq("project_id", project_id).select()

if (tasks.size() > 2000) {
    exit 400, '项目内未完成任务不能超过2000个';
}

// //插入的数据
// var data = {}
// data.parent_id = 0
// data.project_id = projectId
// data.column_id = column.id
// name: name,
//     userid: userid,
//     flow_item_id: flowItemId,
//     flow_item_name: flowItemName,
//     //优先级相关
//     p_level: p_level,
//     p_name: p_name,
//     p_color: p_color,

log.info("info" + times)
start_time = ""
end_time = ""

//时间处理
if (times != "") {
    log.info("info111" + times)
    let timeArr = times.split(',');
    if (timeArr.size() == 2) {
        start_time = timeArr[0]
        end_time = timeArr[1]
    }
}

import cn.hutool.core.util.IdUtil;
import http;

//TODO 创建频道，并将自己加入
let subscribers = []
var useridStr = userid::string
log.info('useridStr:' + useridStr);
subscribers.push(useridStr)
//频道id
channelId = IdUtil.simpleUUID()
log.info('item+' + subscribers);
for (item in subscribers) {
    log.info('item+' + subscribers);
}

//TODO 创建频道，并将自己加入
var responseEntity = http.connect(wukongIMUrl+'/channel').contentType('application/json').body({
    channel_id: channelId, // 频道的唯一ID，如果是群聊频道，建议使用群聊ID
    channel_type: 2, // 频道的类型 1.个人频道 2.群聊频道（个人与个人聊天不需要创建频道，系统将自动创建）
    large: 0, // 是否是超大群，0.否 1.是 （一般建议500成员以上设置为超大群，注意：超大群不会维护最近会话数据。）
    ban: 0, // 是否封禁此频道，0.否 1.是 （被封后 任何人都不能发消息，包括创建者）
    subscribers: subscribers, // 设// 订阅者集合
}).post().getBody();
log.info("添加任务加入频道返回responseEntity" + responseEntity)

//TODO 判断成功与否


//TODO 判断列表是不是属于这个项目
//插入任务表
var taskResult = db.table('project_tasks').insert({
    parent_id: 0, //如果有子任务这里要修改
    project_id: projectId,
    column_id: column_id,
    name: name,
    userid: userid, //创建人
    flow_item_id: flowItemId,
    flow_item_name: flowItemName,
    //优先级相关
    p_level: p_level,
    p_name: p_name,
    p_color: p_color,
    //时间
    start_at: start_time,
    end_at: end_time,
    dialog_id: channelId,
    //排序
    //TODO 内容
})

//插入dialog表
var dialog = db.table("web_socket_dialogs").insert({
    name: name,
    type: "group",
    group_type: "task",
    channel_id: channelId,
})

log.info('taskResult:' + taskResult)


import '@/task/saveContent' as saveContent
import 'cn.hutool.http.HtmlUtil';

if (content != null) {
    let textWithoutHtml = HtmlUtil.cleanHtmlTag(content);
    log.info(textWithoutHtml)
    db.update("""
        update project_tasks set `desc` = #{textWithoutHtml} where id = #{taskResult}
    """)
    saveUrl = saveContent(content, 'update')
    log.info(" saveContent url --->" + saveUrl)
    var contentValue = {}
    contentValue.url = saveUrl
    if (url != "") {
        log.info("project_id--->" + projectId)
        log.info("task_id--->" + taskResult)
        log.info("content--->" + contentValue::stringify)
        //TODO 直接按插入
        var result = db.table('project_task_contents').insert({
            project_id: projectId,
            task_id: taskResult,
            content: contentValue::stringify //  这里存json
        })
    } else {
        exit 400, '内容保存异常';
    }
}

var result
//负责人
//TODO 负责人所有项目未完成加起来不能超过500个
if (owner != "" && owner.length() > 0) {
    log.info("owner：：" + owner)
    let ownerArr = owner.split(',');
    for (item in ownerArr) {
        result = db.table('project_task_users').insert({
            project_id: projectId,
            task_id: taskResult,
            task_pid: taskResult, //不考虑父id
            userid: item,
            owner: 1,
            created_at: now(),
        })
        log.info("负责人插入用户表" + result)
    }
}
if (assist != null) {
    if (assist != "" && assist.length() > 0) {
        log.info("assist" + assist)
        log.info("assist.length()" + assist.length())
        let assistArr = assist.split(',');
        log.info("assistArr size" + assistArr.size())
        for (item in assistArr) {
            log.info("assistArr item" + item)
            result = db.table('project_task_users').insert({
                project_id: projectId,
                task_id: taskResult,
                task_pid: taskResult, //不考虑父id
                userid: item,
                owner: 0,
                created_at: now(),
            })
            log.info("协助人插入用户表" + result)
        }
    }

}


//如果负责人和协助人都没有，就要添加自己为协助人
if (assist == "" && owner == "") {
    result = db.table('project_task_users').insert({
        project_id: projectId,
        task_id: taskResult,
        task_pid: taskResult, //不考虑父id
        userid: userid,
        owner: 0,
        created_at: now(),
    })
    log.info("自己插入用户表" + result)
}

// //协助人
// var owner = userid
// result = db.table('project_task_users').insert({
//     project_id: projectId,
//     task_id: taskResult,
//     task_pid: taskResult,
//     userid: userid,
//     owner: owner,
//     created_at: now(),
// })
//可见性先不考虑了
//子任务也先不考虑了
log.info('插入任务用户表结果' + result)
// })
var data = db.table("project_tasks").where().eq("id", taskResult).selectOne()
//TODO 下面这部分应该不会出现，一边创建项目一边创建任务列表
//任务用户
var taskUser = db.table("project_task_users").where().eq("task_id", taskResult).select()
log.info("taskUser" + taskUser)

data.task_user = taskUser
data.task_tag = []

// data.task_user =  db.table("project_task_users").where().eq("task_id", result).select() 
// 可见性设置
// 首次聊天后才会创建聊天室，所以这里不创建聊天室
// if(newColumn){
//      //将data 转成数组
//      data.new_column = newColumn
// }
//推送消息
return data