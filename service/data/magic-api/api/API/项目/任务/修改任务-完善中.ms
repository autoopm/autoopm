{
  "properties" : { },
  "id" : "9a5d652698364f8f8a98a404342c2727",
  "script" : null,
  "groupId" : "f2a82a98ff1d49a3904430542a3d776d",
  "name" : "修改任务-完善中",
  "createTime" : 1717060653788,
  "updateTime" : 1716869127163,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/update",
  "method" : "POST",
  "parameters" : [ {
    "name" : "token",
    "value" : "a9fc5b73-bbcd-47e9-803a-989822150fe2",
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
  "requestBody" : "{\n  \"task_id\": 205,\n  \"assist\": [\n    7\n  ]\n}",
  "headers" : [ {
    "name" : "token",
    "value" : "58d97f3f-b00b-4050-b6d6-7e31e391ab7d",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"id\": 205,\n        \"parent_id\": 0,\n        \"project_id\": 104,\n        \"column_id\": 146,\n        \"dialog_id\": \"f55e2438470b41e58558a61d2ed0a596\",\n        \"flow_item_id\": 331,\n        \"flow_item_name\": \"start|待处理\",\n        \"name\": \"111\",\n        \"color\": \"\",\n        \"desc\": \"1\",\n        \"start_at\": 1713920400000,\n        \"end_at\": 1714039200000,\n        \"archived_at\": null,\n        \"archived_userid\": 0,\n        \"archived_follow\": 0,\n        \"complete_at\": null,\n        \"userid\": 6,\n        \"visibility\": 1,\n        \"p_level\": 1,\n        \"p_name\": \"重要且紧急\",\n        \"p_color\": \"#ED4014\",\n        \"sort\": 0,\n        \"loop\": \"\",\n        \"loop_at\": null,\n        \"created_at\": null,\n        \"updated_at\": null,\n        \"deleted_at\": null,\n        \"deleted_userid\": 0,\n        \"task_user\": [\n            {\n                \"id\": 108,\n                \"project_id\": 104,\n                \"task_id\": 205,\n                \"task_pid\": 205,\n                \"userid\": 7,\n                \"owner\": 0,\n                \"created_at\": 1713976503000,\n                \"updated_at\": null\n            },\n            {\n                \"id\": 267,\n                \"project_id\": 104,\n                \"task_id\": 205,\n                \"task_pid\": 205,\n                \"userid\": 6,\n                \"owner\": 1,\n                \"created_at\": 1713970132000,\n                \"updated_at\": null\n            }\n        ],\n        \"task_tag\": []\n    },\n    \"timestamp\": 1713976503505,\n    \"executeTime\": 56\n}",
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
      "name" : "task_id",
      "value" : "202",
      "description" : "任务id",
      "required" : true,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
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
      "children" : [ {
        "name" : "",
        "value" : "7",
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
      "value" : "1713975515290",
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
      "value" : "41",
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
import cn.hutool.core.util.EscapeUtil;
import log
import env
var wukongIMUrl = env.get("wukongim.endpoint")
log.info("wukongIMUrl" + wukongIMUrl);

//判断任务能不能操作，比如是否已归档
//判断个人项目是否已经存在
// var userid = StpUtil.getLoginId()
var userid = 6
// var userid = 1
//更新备注
var updateMarking = {}

var data = {}

//TODO 判断当前用户是否是项目负责人或者协助人 或者项目负责人

//任务负责人列表
var oldOwners = db.table("project_task_users").where().eq("task_id", body.task_id).eq("owner", 1).select()
//任务协助人列表
var oldAssists = db.table("project_task_users").where().eq("task_id", body.task_id).eq("owner", 0).select()
for (item in oldAssists) {
    log.info("oldAssists selece value item " + item)

}

//任务负责人userid列表
let oldOwnerUserIds = []
//任务协助人userid列表
let oldAssistUserIds = []

//任务负责人列表
if (oldOwners.size() > 0) {
    log.info("oldOwners size ------>" + oldOwners.size())
    for (item in oldOwners) {
        oldOwnerUserIds.push(item.userid)
        log.info("oldOwners22------>" + item)
    }
} else {
    log.info("历史项目负责人为空------>")
}
//任务协助人列表
if (oldAssists.size() > 0) {
    for (item in oldAssists) {
        oldAssistUserIds.push(item.userid)
        log.info("oldAssists1------>" + item)
    }
} else {
    log.info("历史项目协助人为空------>")
}

//构建任务基础查询
var builder = db.table('project_tasks').where().eq("id", body.task_id)

// 查询项目负责人

var projectOwner
var useTask

var result = builder.selectOne()
useTask = result
var projectId

if (result !== null) {
    projectId = result.project_id
    log.info("projectId--->" + projectId)
    if (projectId !== null) {
        useProject = db.table('projects').where().eq("id", projectId).selectOne()
        log.info("result--->" + useProject)
        if (useProject !== null) {
            log.info("result.userid--->" + useProject.userid)
            projectOwner = useProject.userid
        }
    }
}

for (item in oldOwnerUserIds) {
    log.info("item " + "oldOwnerUserIds" + item)
}

log.info("-------------")
log.info("userid---> " + userid)
log.info("projectOwne---> " + projectOwner)
log.info("projectOwne---> " + (userid::int != projectOwner))
log.info("contains --->" + !oldOwnerUserIds.contains(userid))
log.info("-------------")
//查看是否是项目负责人或者任务负责人，如果不是则不能修改任务状态
if (userid::int != projectOwner && !oldOwnerUserIds.contains(userid)) {
    exit 400, '仅限任务负责人或项目负责人操作'
}

//对比原来的工作流和现在的工作流id
if (body.flow_item_id !== null) {
    //flowData 作为记录插入使用的
    var flowData = {}
    if (useTask.flow_item_id == body.flow_item_id) {
        exit 400, '任务状态未发生改变'
    } else { // 更新到新的工作流
        newFlowItem = db.table("project_flow_items").where().eq("project_id", useTask.project_id).eq('id', body.flow_item_id).selectOne()
        log.info("newFlowItem-->" + newFlowItem)
        if (newFlowItem == null) { //判断任务状态是否存在
            exit 400, '任务状态不存在'
        }
        if (useTask.flow_item_id != '') { //判断当前工作流id不为空
            currentFlowItem = db.table("project_flow_items").where().eq("project_id", useTask.project_id).eq('id', useTask.flow_item_id).selectOne()
            //判断符合流转 
            turnStr = currentFlowItem.turns.substring(1, currentFlowItem.turns.length() - 1)
            log.info("currentFlowItem.id turnStr" + turnStr)
            let turnArr2 = turnStr.split(', '); //TODO 这里需要处理
            //判断是否能变更
            if (!turnArr2.some(e => e == currentFlowItem.id::string)) {
                exit 400, '当前状态[' + currentFlowItem.name + ']不可流转到[' + newFlowItem.name + ']'
            }

            //TODO  userlimit 这里处理也不行
            if (currentFlowItem.userlimit) {
                //判断是否是当前状态的负责人或者项目负责人
                if (userid != projectOwner || !currentFlowItem.userids.contains(userid)) {
                    exit 400, '当前状态[' + currentFlowItem.name + ']仅限状态负责人或项目负责人修改'
                }
            }
        }
        data.flow_item_id = newFlowItem.id
        data.flow_item_name = newFlowItem.status + '|' + newFlowItem.name

        //判断状态为完成状态，则修改任务的完成时间
        if (newFlowItem.status == 'end') {
            //判断原来的任务完成时间为空
            if (useTask.complete_at == null) {
                data.complete_at = now() //更新任务的完成时间
            }
        } else {
            log.info("任务状态变更3")
            if (useTask.complete_at != null) {
                log.info("任务状态变更1")
                data.complete_at = null //更新任务的完成时间为空
                log.info("任务状态变更2")
            }
        }
        //根据工作流自动添加负责人
        log.info(currentFlowItem.userids)
        if (newFlowItem.userids.length() > 0) {
            log.info("状态负责人已设置")
            //判断自动添加负责人
            //获取任务当前的负责人userid数组
            var taskUser = db.table("project_task_users").where().eq("task_id", body.task_id).eq("owner", 1).select()
            //当前的负责人
            let userids = [];
            for (item in taskUser) {
                userids.push(item.userid)
            }
            //流转模式   
            if (newFlowItem.usertype.contains('replace')) {
                if (useTask.parent_id == 0) { //现阶段应该还没有父任务
                    //原本的任务负责人移至协助人员
                    for (item in userids) {
                        result = db.table(tableName).primary("task_id").primary("project_id").primary("userid") update({
                            userid: item,
                            task_id: useTask.id,
                            project_id: useTask.project_id,
                            owner: 0,
                        })
                        log.info('原本的任务负责人移至协助人员' + result)
                    }


                    let useridArr = newFlowItem.userids.substring(1, newFlowItem.userids.length() - 1).split(', ')

                    //改变任务负责人为状态负责人
                    for (item in useridArr) {
                        result = db.table('project_task_users').insert({
                            project_id: useTask.project_id,
                            task_id: useTask.id,
                            task_pid: useTask.id,
                            userid: item,
                            owner: 1,
                            created_at: now(),
                        })
                        log.info('改变任务负责人为状态负责人' + result)
                    }
                }
            } else if (newFlowItem.usertype.contains('merge')) { //剔除模式
                if (useTask.parent_id == 0) { //现阶段应该还没有父任务
                    //改变任务负责人为状态负责人（并保留操作状态的人员），原本的任务负责人移至协助人员。
                    //当前用户保留
                    //起一个数组记录要修改任务人员属性的
                    var updateData = {}
                    //将状态负责人都设为状态负责人
                    for (item in newFlowItem.userid) {
                        updateData.push({
                            userid: item,
                            owner: 1,
                        })
                    }
                    //当前操作人员也保留是任务负责人
                    updateData.push({
                        userid: userid,
                        owner: 1,
                    })

                    //更新为协助人的userid
                    let assistUpdateList = userids.filter(userid => !updateData.some(data => data.userid === userid));
                    log.info('-------------------------------')
                    log.info('assistUpdateList')
                    log.info('-------------------------------')
                    //将协助人列表添加到更新数据中去
                    for (item in assistUpdateList) {
                        updateData.push({
                            userid: item,
                            owner: 0,
                        })
                    }
                    // 更新数据
                    for (item in updateData) {
                        result = db.table('project_task_users').primary("project_id").primary("task_id").save({ //这里估计会有问题
                            project_id: useTask.project_id,
                            task_id: useTask.id,
                            task_pid: useTask.id,
                            userid: updateData.usedid,
                            owner: updateData.owner
                        })
                    }
                    //任务负责人中不是状态负责人设为任务协助人（设置owner为0）
                }
            } else { //添加模式
                // 添加状态负责人至任务负责人。
                let useridArr = newFlowItem.userids.substring(1, newFlowItem.userids.length() - 1).split(', ')
                for (item in useridArr) {
                    result = db.table('project_task_users')
                        .primary("project_id").primary("task_id").primary('userid').save({
                            project_id: useTask.project_id,
                            task_id: useTask.id,
                            task_pid: useTask.id,
                            userid: item,
                            owner: 1,
                            created_at: now(),
                        })
                }
            }
            //修改任务状态的日志
            var logDetail = '修改任务状态,change[' + currentFlowItem.name + ',' + newFlowItem.name + ']'
            var project_log = db.table('project_logs').insert({
                project_id: useTask.project_id,
                column_id: 0,
                task_id: useTask.id,
                userid: userid,
                detail: logDetail
            })

            //TODO 流程改变的记录
            result = db.table('project_task_flow_changes').insert({
                task_id: useTask.id,
                userid: userid,
                before_flow_item_id: useTask.flow_item_id,
                before_flow_item_name: useTask.flow_item_name,
                after_flow_item_id: body.flow_item_id,
                after_flow_item_name: body.flow_item_name,

            })
            log.info("流程改变的记录插入" + result)
        } else {
            log.info("状态负责人未设置")
        }
    }
}

data.id = body.task_id
log.info('data ->task_id ' + data);

//TODO  loop、visibility_appointor 重复周期先不管

if (body.complete_at !== null) {
    if (useTask.complete_at != null) {
        exit 400, '任务已完成'
    }

    data.complete_at = body.complete_at
    updateMarking.is_update_project = true;
}
//名称修改
if (body.name !== null) {
    if (body.name == '') {
        exit 400, '任务描述不能为空'
    }

    if (body.name.length() > 255) {
        exit 400, '任务描述最多只能设置255个字'
    }
    data.name = body.name
    //添加日志
    var logDetail = '修改任务标题,change[' + useTask.name + ',' + body.name + ']'
    var project_log = db.table('project_logs').insert({
        project_id: useTask.project_id,
        column_id: 0,
        task_id: useTask.id,
        userid: userid,
        detail: logDetail
    })

    //更新聊天室的标题
    dialog = db.table('web_socket_dialogs').primary('channel_id').update({
        channel_id: useProject.dialogId,
        name: body.name
    })

    //更新聊天室的标题
    // if (useTask.dialog_id) {
    //     result = db.table("web_socket_dialogs").primary("id").update({
    //         id: useTask.dialog_id,
    //         name: body.name
    //     })
    // }
}

//任务负责人的修改逻辑
if (body.owner !== null) {
    log.info("body.owner value" + body.owner)
    // data.owner = body.owner
    newOwner = body.owner
    if (newOwner.size() > 10) {
        exit 400, '任务负责人最多不能超过10个'
    }

    //强转成 string
    let subscribers = []
    for (item in newOwner) {
        subscribers.push(item::string)
    }

    //TODO newOwner 要强转成 string 
    //更新频道，直接挪出去直接不见人，消息也不发了。
    var channelId = useTask.dialog_id
    log.info('subscribers value+' + newOwner);
    log.info('--------------------->' + newOwner.size())
    if (chanelId) {
        var responseEntity = http.connect(wukongIMUrl+'/channel/subscriber_add').contentType('application/json').body({
            channel_id: channelId, // 频道的唯一ID，如果是群聊频道，建议使用群聊ID
            channel_type: 2, // 频道的类型 1.个人频道 2.群聊频道（个人与个人聊天不需要创建频道，系统将自动创建）
            reset: 1, // 是否重置订阅者 （0.不重置 1.重置），选择重置，则删除旧的订阅者，选择不重置则保留旧的订阅者   
            subscribers: subscribers, //订阅者集合
        }).post().getBody();
        log.info("更新频道返回结果" + responseEntity)
        if (responseEntity.status == 200) {
            log.info("频道更新成功")
        } else {
            log.info("频道更新失败")
            exit 400, "频道更新失败";
        }
    }




    //原本的负责人
    var taskUser = db.table("project_task_users").where().eq("task_id", body.task_id).eq("owner", 1).select()
    //找出新负责人中不在原负责人列表中的人员，然后删除
    // let filteredTaskUser = taskUser.filter(obj => newOwner.contains(obj.userid));
    for (item in taskUser) {
        log.info("原本的负责人---------->" + item)
    }
    //这句还是得改

    let filteredTaskUser = taskUser.filter(obj => newOwner.contains(obj.userid));

    // let filteredTaskUser = taskUser.filter(obj => newOwner.contains(obj.userid));
    if (filteredTaskUser.size() > 0) {
        for (item in filteredTaskUser) {
            log.info('负责人不在旧列表中的->' + item)
        }
    }

    //先删后加
    for (item in taskUser) {
        db.table("project_task_users").where().eq("id", item.id).delete()
    }

    //TODO 如果旧的任务中已经有了就不管了
    // console.log(filteredTaskUser);
    for (item in newOwner) {
        log.info('newOwner list->' + item)
        result = db.table('project_task_users').insert({
            project_id: useTask.project_id,
            task_id: useTask.id,
            task_pid: useTask.id,
            userid: item,
            owner: 1,
            created_at: now(), //TODO 考虑使用全局添加的方式
        })
        // result = db.table('project_task_users').primary("project_id").primary("task_id").primary('userid').save({
        //     project_id: useTask.project_id,
        //     task_id: useTask.task_id,
        //     task_pid: useTask.task_pid,
        //     userid: item, 
        //     owner: 1,
        //     created_at: now(), //TODO 考虑使用全局添加的方式
        // })

        // db.update("""
        //     update project_task_users set owner = 1,created_at = now()  where project_id = #{useTask.project_id} and task_id =  #{useTask.task_id} and  userid =  #{item} 
        // """)
    }

    //删除不是负责人的
    for (item in filteredTaskUser) {
        result = db.table('project_task_users').where().eq('userid', item.userid).eq('project_id', useTask.project_id).eq('task_id', useTask.id).eq("owner", 1).delete()
        log.info('result' + result)
    }

    //TODO 同步聊天室成员
}

//任务协助人的修改逻辑
//  协助人
if (body.assist !== null) {
    log.info("body.assist value" + body.assist)
    //赋值newAssist
    newAssist = body.assist

    //强转成 string
    let subscribers = []
    for (item in newAssist) {
        subscribers.push(item::string)
    }
    //更新频道，直接挪出去直接不见人，消息也不发了。
    var channelId = useTask.dialog_id
    log.info('subscribers value+' + newAssist);
    log.info('--------------------->' + newAssist.size())
    if (chanelId) {
        var responseEntity = http.connect(wukongIMUrl+'/channel/subscriber_add').contentType('application/json').body({
            channel_id: channelId, // 频道的唯一ID，如果是群聊频道，建议使用群聊ID
            channel_type: 2, // 频道的类型 1.个人频道 2.群聊频道（个人与个人聊天不需要创建频道，系统将自动创建）
            reset: 1, // 是否重置订阅者 （0.不重置 1.重置），选择重置，则删除旧的订阅者，选择不重置则保留旧的订阅者   
            subscribers: subscribers, //订阅者集合
        }).post().getBody();
        log.info("任务协助人-》更新频道返回结果" + responseEntity)
        if (responseEntity.status == 200) {
            log.info("任务协助人-》频道更新成功")
        } else {
            log.info("任务协助人-》频道更新失败")
            exit 400, "频道更新失败";
        }
    } else {
        log.info("chanelId为空！")
    }

    var taskUser = db.table("project_task_users").where().eq("task_id", body.task_id).eq("owner", 0).select()
    //找出新协助人中不在协助人人列表中的人员，然后删除


    let filteredTaskUser = taskUser.filter(obj => newAssist.contains(obj.userid));

    // let filteredTaskUser = taskUser.filter(obj => !newAssist.includes(obj.userid)); //报错了

    if (filteredTaskUser != null) {
        log.info('协助人在旧列表中的' + filteredTaskUser)
        for (item in filteredTaskUser) {
            log.info('旧的协助人列表' + item)
        }
    }

    //更新协助人
    for (item in newAssist) {
        result = db.table('project_task_users').primary("project_id").primary("task_id").primary('userid').save({
            project_id: useTask.project_id,
            task_id: useTask.id,
            task_pid: useTask.id,
            userid: item,
            owner: 0,
            created_at: now(), //TODO 考虑使用全局添加的方式
        })
    }

    //删除旧的协助人
    for (item in filteredTaskUser) {
        result = db.table('project_task_users').where().eq('userid', item.userid).eq('project_id', useTask.project_id).eq('task_id', useTask.id).eq("owner", 0).delete()
        log.info('删除旧的协助人' + result)
    }

}


//计划时间
if (body.times !== null) {
    log.info('修改计划时间--')
    time = body.times
    // data.start_at = time[0]
    // data.end_at = time[1]
    // log.info(data)

    result = db.table('project_tasks').where().eq('project_id', useTask.project_id).eq('id', useTask.id).update({
        project_id: useTask.project_id,
        id: useTask.id,
        start_at: time[0],
        end_at: time[1]
    })

    log.info("更新任务时间返回", project_log)
    var desc = body.desc ? '(备注：' + desc + ')' : ''
    var logDetail = '修改任务时间' + desc + '[' + useTask.start_at + '~' + useTask.end_at + ',' + time[0] + '~' + time[1] + ']'
    var project_log = db.table('project_logs').insert({
        project_id: useTask.project_id,
        column_id: 0,
        task_id: useTask.id,
        userid: userid,
        detail: logDetail
    })
    log.info("插入修改任务时间的日志", project_log)
    //TODO 还有修改备注

}
var p = false
//优先级相关
var oldPname = useTask.p_name
if (body.p_level !== null && body.p_level != useTask.p_level) {
    data.p_level = body.p_level
    p = true
}

if (body.p_color !== null && body.p_color != useTask.p_color) {
    data.p_color = body.p_color
    p = true
}

if (body.p_name !== null && body.p_name != useTask.p_name) {
    data.p_name = body.p_name
    p = true
}

if (p) {

    var logDetail = '修改任务时间' + desc + '[' + useTask.start_at + '~' + useTask.end_at + ',' + time[0] + '~' + time[1] + ']'
    var project_log = db.table('project_logs').insert({
        project_id: useTask.project_id,
        column_id: 0,
        task_id: useTask.id,
        userid: userid,
        detail: logDetail
    })
    log.info("修改任务优先级" + ',change=>[' + p_name + ',' + ']')
}

//颜色
if (body.color !== null && body.color != useTask.color) {
    data.color = body.color
}

//列表
var column

if (body.column_id !== null) {
    if (body.column_id != useTask.column_id) {
        log.info('新列表-----')
        //判断列表是否存在
        oldName = db.table("project_columns").where().eq('project_id', useTask.project_id).eq('id', useTask.column_id).selectOne().name
        column = db.table("project_columns").where().eq('project_id', useTask.project_id).eq('id', body.column_id).selectOne()
        if (column == null) {
            exit 400, '请选择正确的列表'
        }

        log.info(column)
        var logDetail = '修改任务列表,change=>[' + oldName + ',' + column.name + ']'
        var project_log = db.table('project_logs').insert({
            project_id: useTask.project_id,
            column_id: 0,
            task_id: useTask.id,
            userid: userid,
            detail: logDetail
        })
        log.info("插入列表的日志", project_log)
        data.column_id = body.column_id

    } else { //如果和之前一样则不考虑
        exit 400, '列表无变化'
    }
}

import '@/task/saveContent' as saveContent
import 'cn.hutool.http.HtmlUtil';
//详细描述空值是允许的
if (body.content !== null) {
    log.info("进入这里")
    //保存html在这里先 
    let textWithoutHtml = HtmlUtil.cleanHtmlTag(body.content);
    log.info(textWithoutHtml)
    //直接插入保存了，应为data不能留着
    // data.desc = textWithoutHtml
    //直接插入了
    // res = db.table("project_tasks").primary("id").update({
    //     id: body.task_id,
    //     'desc': textWithoutHtml,
    // })
    db.update("""
        update project_tasks set `desc` = #{textWithoutHtml} where id = #{body.task_id}
    """)
    // log.info("插入desc的value" + res)

    saveUrl = saveContent(body.content, 'update')
    log.info(" saveContent url --->" + saveUrl)
    var contentValue = {}
    contentValue.url = saveUrl
    if (url != "") {
        log.info("project_id--->" + useTask.project_id)
        log.info("task_id--->" + useTask.id)
        log.info("content--->" + contentValue::stringify)
        // var result = db.table('project_task_contents').where('project_id').primary('task_id').update({
        //     project_id: project_id,
        //     task_id: task_id,
        //     content: contentValue::json //  这里存json
        // })
        //TODO 直接按插入
        var result = db.table('project_task_contents').insert({
            project_id: useTask.project_id,
            task_id: useTask.id,
            content: contentValue::stringify //  这里存json
        })

        log.info("insert project_task_contents ->result:", result)
    } else {
        exit 400, '内容保存异常';
    }
}

log.info('要更新的数据' + data);
var result = builder.update(data, true)
log.info('result is' + result)




//重新查询
useTask = db.table("project_tasks").where().eq("id", body.task_id).selectOne();

//任务成员列表
var taskUser = db.table("project_task_users").where().eq("task_id", body.task_id).select()
useTask.task_user = taskUser

//任务标签 
useTask.task_tag = []
return useTask