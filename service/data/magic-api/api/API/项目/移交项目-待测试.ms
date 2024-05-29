{
  "properties" : { },
  "id" : "f193bc0459c943aeb83c5debc6ff5ff2",
  "script" : null,
  "groupId" : "0c2d9f4051a44b37a9a0f361f4e13b75",
  "name" : "移交项目-待测试",
  "createTime" : 1716867159574,
  "updateTime" : 1713325088328,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/transfer",
  "method" : "GET",
  "parameters" : [ {
    "name" : "project_id",
    "value" : "9",
    "description" : "项目ID",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "owner_userid",
    "value" : "2",
    "description" : "新的项目负责人ID",
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
    "value" : "1084b6f5-ce65-4d93-b2f4-6e9d7ac409af",
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
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import '@/project/use' as use
import '@/project/log' as log
var useProject = use()
result = db.table("users").where().eq("id", owner_userid).selectOne()
if (result == null) {
    exit 400, '成员不存在'
}
var val = db.transaction(() => {
    //变更用户
    db.table("project_users").primary("project_id").primary("userid").update({
        project_id: project_id,
        userid: userid,
        owner: 0
    })

    db.table("project_users").primary("project_id").primary("userid").update({
        project_id: project_id,
        userid: userid,
        owner: 1
    })
    //TODO 更新聊天室

    var result = log('移交项目给[' + owner_userid + ']')
});


//TODO 推送消息

var data = {}
data.id = useProject.id

return data