{
  "properties" : { },
  "id" : "ac35656c8123461e8c01e5bfa604a0ee",
  "script" : null,
  "groupId" : "6f106ebdee21489db34b956f7770ff03",
  "name" : "保存代码",
  "createTime" : null,
  "updateTime" : 1710083195471,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/saveCode",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "component:save:code",
    "description" : "允许拥有该权限的访问",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import 'cn.dev33.satoken.stp.StpUtil';

var currentUserId = StpUtil.getLoginId()

if(db.selectInt("select count(1) from sys_dynamic_component where id = #{id} and is_del = 0") == 0){
    exit 0, '文件不存在'
}

db.table("sys_dynamic_component_history").insert({
    id: uuid(),
    componentId: id,
    sourceCode,
    createBy: currentUserId
})

return db.table("sys_dynamic_component").where().eq("id",id).update({
    sourceCode,
    compileJs,
    compileCss
})