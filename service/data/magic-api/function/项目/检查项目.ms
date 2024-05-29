{
  "properties" : { },
  "id" : "c92e6b48b9294e26b398c7bf271425bc",
  "script" : null,
  "groupId" : "f1893ea1928d488999804afc6c84e785",
  "name" : "检查项目",
  "createTime" : 1716867164156,
  "updateTime" : 1713024595607,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/use",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ ]
}
================================
import 'cn.dev33.satoken.stp.StpUtil';

var useProject = db.table("projects").where().eq("id", project_id).notNull("archived_at").selectOne()
if (useProject == null) {
    exit 400, '项目不存在或已归档'
}
return useProject


