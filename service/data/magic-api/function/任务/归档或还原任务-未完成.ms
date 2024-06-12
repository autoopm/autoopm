{
  "properties" : { },
  "id" : "05a6cfb2c0de4d2082834597ca8d86bd",
  "script" : null,
  "groupId" : "07213facdab54280b6ba7b4637732337",
  "name" : "归档或还原任务-未完成",
  "createTime" : 1717813170662,
  "updateTime" : 1713024595276,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/archivedTask",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ {
    "name" : "archived_at",
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
  } ]
}
================================
import 'cn.dev33.satoken.stp.StpUtil';
var userid = StpUtil.getLoginId()
import '@/project/log' as log
//TODO 判断权限部分

// primary("id").primary

var val = db.transaction(() => {
    if (archived_at == null) {
        db.table("project_tasks").where().eq("project_id", project_id).eq("id", task_id).update({
            archived_at: null,
            archived_follow: 0,
        })
        log('任务取消归档')
    } else {
        //任务归档
        db.table("project_tasks").where().eq("project_id", project_id).eq("id", task_id).update({
            archived_at: archived_at,
            archived_follow: 1,
        })
        log('任务归档')
        //推送归档的通知
    }
    db.table("projects").primary("id").update({
        id: project_id,
        archived_at: archived_at,
        archived_userid: userid
    })

});