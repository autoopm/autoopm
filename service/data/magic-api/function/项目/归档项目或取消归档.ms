{
  "properties" : { },
  "id" : "f8514c3cb7634c71a8160d4428884eab",
  "script" : null,
  "groupId" : "f1893ea1928d488999804afc6c84e785",
  "name" : "归档项目或取消归档",
  "createTime" : 1717813170710,
  "updateTime" : 1713024595523,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/archivedProject",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ {
    "name" : "archived_at",
    "value" : null,
    "description" : "归档时间",
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

var val = db.transaction(() => {
    if (archived_at == null) {
        //项目取消归档
        //推送取消归档的通知
        db.table("project_tasks").primary("project_id").primary("archived_follow").update({
            project_id: project_id,
            archived_follow: 1,
            archived_at: null,
            archived_follow: 0,

        })
        log('项目取消归档')
    } else {
        //项目归档
        db.table("project_tasks").primary("project_id").primary("archived_at").update({
            project_id: project_id,
            archived_at: null,
            archived_at: archived_at,
            archived_follow: 1,
        })
        log('项目归档')
        //推送归档的通知
    }

    db.table("projects").primary("id").update({
        id: project_id,
        archived_at: archived_at,
        archived_userid: userid
    })

});