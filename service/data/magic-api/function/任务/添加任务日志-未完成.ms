{
  "properties" : { },
  "id" : "7a537422c5e54c02a7dcd651f37028b2",
  "script" : null,
  "groupId" : "07213facdab54280b6ba7b4637732337",
  "name" : "添加任务日志-未完成",
  "createTime" : 1716867163069,
  "updateTime" : 1713024595362,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/log",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ ]
}
================================
import 'cn.dev33.satoken.stp.StpUtil';
import log

var userid = StpUtil.getLoginId()
log.info('userid is ' + userid)

if (userid == null) {
    log.info('userid is null')
    exit 400, '用户未登录'
}
log.info('logDetail value：' + logDetail)

var result = db.table('project_logs').insert({
    project_id: project_id,
    column_id: 0,
    task_id: 0,
    userid: userid,
    detail: logDetail
})

log.info('日志插入' + result)
return result