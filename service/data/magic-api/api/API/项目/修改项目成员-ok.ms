{
  "properties" : { },
  "id" : "ef2191dc61ba491cb4a295d221f6fb51",
  "script" : null,
  "groupId" : "0c2d9f4051a44b37a9a0f361f4e13b75",
  "name" : "修改项目成员-ok",
  "createTime" : 1717060653728,
  "updateTime" : 1716877465979,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/user",
  "method" : "GET",
  "parameters" : [ {
    "name" : "project_id",
    "value" : "35",
    "description" : "项目ID",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : "",
    "children" : null
  }, {
    "name" : "userid",
    "value" : "21,17",
    "description" : "成员ID 或 成员ID组",
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
    "value" : "d625f2aa-4130-40d6-9e8a-7d89f44422a6",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": \"修改成功\",\n    \"timestamp\": 1711107258377,\n    \"executeTime\": 34\n}",
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
      "value" : "1708446696677",
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
      "value" : "21",
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
import log
import 'cn.dev33.satoken.stp.StpUtil';
import http;
import env

var wukongIMUrl = env.get("wukongim.endpoint")
log.info("wukongIMUrl" + wukongIMUrl);



if (!StpUtil.isLogin()) {
    exit - 1, '请登录后继续';
}
var projectId = project_id
var loginUserid = StpUtil.getLoginId()
var userids = userid.split(','); //最新的项目成员id数组
if (userids.getLength() > 100) { //判断项目人数最多100人
    exit 400, '项目人数最多100人'
}
var useProject = db.table("projects").where().eq("id", projectId).notNull("archived_at").selectOne() //获取项目信息
if (useProject == null) {
    exit 400, '项目不存在或已归档'
}


//启动事务
var val = db.transaction(() => {

    //更新频道信息
    var channelId = useProject.dialog_id

    log.info('useProject channelId+' + channelId);
    log.info('useProject value+' + useProject);
    log.info(useProject);
    //处理进来的用户 id
    // let subscribers = []
    // for (item in userids) {
    // subscribers.push(useridStr)
    // }
    log.info('userids value+' + userids);


    //强转成 string
    let subscribers = []
    for (item in userids) {
        subscribers.push(item::string)
    }

    log.info("开始请求1")
    if (chanelId != "") {
        log.info("开始请求2")
        var responseEntity = http.connect(wukongIMUrl + '/channel/subscriber_add').contentType('application/json').body({
            channel_id: channelId, // 频道的唯一ID，如果是群聊频道，建议使用群聊ID
            channel_type: 2, // 频道的类型 1.个人频道 2.群聊频道（个人与个人聊天不需要创建频道，系统将自动创建）
            reset: 1, // 是否重置订阅者 （0.不重置 1.重置），选择重置，则删除旧的订阅者，选择不重置则保留旧的订阅者   
            subscribers: subscribers, //订阅者集合
        }).post().getBody();
        log.info("开始请求3")
        log.info("更新频道返回结果" + responseEntity)

        if (responseEntity.status == 200) {
            log.info("频道更新成功")
        } else {
            log.info("频道更新失败")
            exit 400, "频道更新失败";
        }
    }




    //新增的项目成员加入项目
    //旧的列表中的数据
    var oldUserList = db.table('project_users').where().eq('project_id', projectId).select()
    // //要更新的数组
    // var updateUser = []
    // for (item in oldUserList) {
    //     for (item2 in userids) { //如果遍历中存在
    //         if (item.userid == item2) {
    //             updateUser.push(item2)
    //         }
    //     }
    // }
    log.info(userids::string)
    var updateItems = userids.filter(item => oldUserList.some(obj => obj.userid == item));
    log.info("updateItems")
    // log.info(updateItems)
    for (item in updateItems) {
        log.info("更新列表数据：" + item::string)
        // db.table('project_users').primary('project_id').primary("userid").update({
        //     project_id: projectId,
        //     userid: item,
        //     owner: 1
        // })

        // db.table("project_users").primary('project_id', 'userid').update({
        //     project_id: projectId,
        //     userid: item,
        //     owner: 1
        // })
        db.update("""
            update project_users set owner = 1  where project_id = #{projectId} and userid =  #{item}
        """)

        //         var projectTasks = db.select("""
        //     SELECT
        //         project_tasks.*,
        //         project_task_users.owner,
        //         1 AS assist
        //     FROM
        //         project_tasks
        //     left JOIN
        //         project_task_users ON project_tasks.id = project_task_users.task_id
        //     WHERE
        //         project_task_users.userid = #{userid}
        //     AND
        //         project_task_users.owner = 1 
        //     AND
        //         project_task_users.project_id = #{project_id}     
        // """)

    }

    var unequalItems = userids.filter(item => !oldUserList.some(obj => obj.userid == item));
    log.info("不在列表中的进行插入")
    for (item in unequalItems) {
        log.info("不在列表中的进行插入" + item)
        db.table("project_users").insert({
            project_id: projectId,
            userid: item,
            owner: 1
        })
    }
    //获取不在表中的人员id的信息
    var userList = db.table('project_users').where().eq('project_id', projectId).notIn('userid', userids).select()

    //移除的人员id数组
    log.info("移除的人员id数组 ->" + userList)
    //如果有删除人员,将这些人员退出任务和聊天室
    if (userList.size() > 0) {
        let deleteUserIds = [];
        //获取删除掉的人员的id列表
        for (item in userList) {
            deleteUserIds.push(item.userid)
        }
        log.info("deleteUserIds is ", deleteUserIds)
        //获取到删除人员的所有项目任务，从用户表找到相关的任务id列表
        var taskUserList = db.table('project_task_users').where().eq('project_id', projectId).in('userid', deleteUserIds).select()
        log.info("任务列表 taskUserList is ", taskUserList)
        // log.info(taskUserList)
        if (taskUserList.size() > 0) {
            var tastIds = [];
            for (taskUser in taskUserList) {
                tastIds.push(taskUser.taskId)
            }
            log.info("tastIds is " + tastIds)
        }

        if (taskIds != null) {
            //循环删除项目和项目聊天室 todo 先不考虑子任务的情况
            for (task in tastIds) {
                //获取的任务聊天室dialogId
                var taskDialogId = task.dialogId
                //退出任务聊天室
                var taskDialogResult = db.table('web_socket_dialog_users').where().eq('dialog_id', taskDialogId).in('userid', deleteUserIds).delete()
            }
            //退出任务 删除项目任务用户表
            var delResult = db.table('project_task_user').where().eq('project_id', projectId).in('userid', deleteUserIds).delete()
            log.info("删除项目任务用户表" + delResult)
        }

        //从项目用户表中移除
        var delUserResult = db.table('project_users').where().eq('project_id', projectId).notIn('userid', userids).delete()
        log.info("delUserResult result --->" + delUserResult)
    }

    // //同步项目聊天室成员
    // var dialog = db.table('web_socket_dialogs').where().eq('id', useProject.dialog_id).selectOne()

    //TODO 同步项目聊天室成员
    // log.info("dialog is " + dialog)
    // //聊天id
    // var dialogId = dialog.id
    // for (item in userids) {
    //     var result = db.table('web_socket_dialog_user').primary('id').saveOrUpdate({
    //         dialog_id: dialogId,
    //         userid: item
    //     })
    //     log.info("web_socket_dialog_user result  ->" + result)
    // }
    // //将移除的用户从项目聊天室中移除
    // var delResult = db.table('web_socket_dialog_user').where().eq('dialog_id', dialogId).notIn('userid', userids).delete()
    // log.info("delResult  ->" + delResult)
});

//添加项目修改成员日志 todo 确认放不放userid ，这个userid是使用的当前用户还是列表上传的
var logDetail = '修改项目成员'
var project_log = db.table('project_logs').insert({
    project_id: projectId,
    column_id: 0,
    task_id: 0,
    userid: loginUserid,
    detail: logDetail
})

//推送成员移除消息
return '修改成功'