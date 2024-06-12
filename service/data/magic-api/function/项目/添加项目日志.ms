{
  "properties" : { },
  "id" : "9fe6c92a4e334d5198e3cacd1923cc1e",
  "script" : null,
  "groupId" : "f1893ea1928d488999804afc6c84e785",
  "name" : "添加项目日志",
  "createTime" : 1717813170721,
  "updateTime" : 1713024595760,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/log",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ {
    "name" : "detail",
    "value" : null,
    "description" : "日志内容",
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.String",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ]
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