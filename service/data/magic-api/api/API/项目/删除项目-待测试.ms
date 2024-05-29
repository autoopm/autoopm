{
  "properties" : { },
  "id" : "01577be29c86402090331f67fdd726db",
  "script" : null,
  "groupId" : "0c2d9f4051a44b37a9a0f361f4e13b75",
  "name" : "删除项目-待测试",
  "createTime" : null,
  "updateTime" : 1716877617158,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/remove",
  "method" : "GET",
  "parameters" : [ {
    "name" : "project_id",
    "value" : "85",
    "description" : "项目id",
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
    "value" : "6c2ca735-04aa-4305-8036-5e90535d6355",
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
  "responseBody" : "{\n    \"code\": 500,\n    \"message\": \"系统内部出现错误\",\n    \"data\": null,\n    \"timestamp\": 1712059662458,\n    \"executeTime\": 66\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import '@/project/use' as use
import '@/project/log' as logI
import log
import http
import env

var wukongIMUrl = env.get("wukongim.endpoint")
log.info("wukongIMUrl" + wukongIMUrl);

//判断项目状态
var useProject = use()
var val = db.transaction(() => {
    //删除项目聊天室  TODO 标记已读状态
    // db.table("web_socket_dialogs").primary("id").update({
    //     id: useProject.dialog_id,
    //     userid: userid,
    //     deleted_at: now()
    // })
    //删除项目聊天室
    channelId = useProject.dialog_id
    log.info("channelId--->",channelId)
    //删除频道id
    var responseEntity = http.connect(wukongIMUrl+'/channel/delete').contentType('application/json').body({
        channel_id: channelId, // 频道的唯一ID
        channel_type: 2, // 频道的类型 1.个人频道 2.群聊频道
    }).post().getBody();
    log.info("删除频道返回responseEntity" + responseEntity)
    if (responseEntity.status == 200) {
        log.info("删除频道成功")
    } else {
        log.info("删除频道失败")
        exit 400, "删除频道失败";
    }
    //
    //删除项目
    db.table("projects").primary("id").update({
        id: project_id,
        deleted_at: now()
    })

    // 删除任务列表
    columns = db.table("project_columns").where().eq("project_id", project_id).select()
    for (item in columns) {
        //遍历出所有任务
        tasks = db.table("project_tasks").where().eq("project_id", item).select()
        //删除任务
        for (item2 in tasks) {
            db.table("project_tasks").primary("id").update({
                id: item2.id,
                deleted_at: now()
            })
        }
        //删除列表
        db.table("project_columns").primary("id").update({
            id: item.id,
            deleted_at: now()
        })
    }
    //添加删除日志
    logI('删除项目')
});

var data = {
    "id":useProject.id
}
//推送删除信息
return data