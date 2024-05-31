{
  "properties" : { },
  "id" : "ab852a29e8614b089e27c0dcad1430da",
  "script" : null,
  "groupId" : "f2a82a98ff1d49a3904430542a3d776d",
  "name" : "删除任务-待测试",
  "createTime" : 1717060653805,
  "updateTime" : 1713024593833,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/remove",
  "method" : "GET",
  "parameters" : [ {
    "name" : "task_id",
    "value" : "194",
    "description" : "任务ID",
    "required" : true,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "type",
    "value" : "",
    "description" : "类型 recovery: 还原 delete: 删除（默认）",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "delete",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ {
    "name" : "token",
    "value" : "5aaaf652-1abb-4213-9709-e99296c8c250",
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
  "responseBody" : "{\n    \"code\": 500,\n    \"message\": \"系统内部出现错误\",\n    \"data\": null,\n    \"timestamp\": 1712684564102,\n    \"executeTime\": 11\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import 'cn.dev33.satoken.stp.StpUtil';
import log

//判断个人项目是否已经存在
var userid = StpUtil.getLoginId()
log.info("userid is" + userid)


var useTask = db.table("project_tasks").where().eq("id",task_id).selectOne()
if (useTask != null) {
    //TODO 推送消息
    if (type == 'recovery') { //还原操作
      //暂时不考虑

    } else { //删除操作，软删除
        //先删除聊天室
        // db.table("WebSocketDialog").where().eq("id", useTask.dialog_id).delete()
        // //删除任务，标记删除人
        db.table("project_tasks").primary("id", task_id).update({
            id:task_id,
            deleted_at:now(),
            deleted_userid:userid, 
        })

        //添加操作日志
        var logDetail = '删除任务' //TODO 应该还带其他的
        var project_log = db.table('project_logs').insert({
            project_id: useTask.project_id,
            column_id: 0,
            task_id: useTask.id,
            userid: userid,
            detail: logDetail
        })
        //推送删除消息
    }
}
return 'success'