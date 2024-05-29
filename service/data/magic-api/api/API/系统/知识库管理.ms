{
  "properties" : { },
  "id" : "4b38de2f260945599630496e4f0b20d7",
  "script" : null,
  "groupId" : "a0d32feaa58a4d318032215149d5cf40",
  "name" : "知识库管理",
  "createTime" : 1716867158705,
  "updateTime" : 1716567478821,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/know",
  "method" : "POST",
  "parameters" : [ {
    "name" : "type",
    "value" : "save",
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
  "requestBody" : "{\n  \"know\": {\n    \"linkUrl\": \"123131313\",\n    \"user\": \"123131313\",\n    \"pwd\": \"13131313\",\n    \"appid\": \"13131313\",\n    \"iframeUrl\": \"1313131313\",\n    \"auto_upload\": \"open\"\n  }\n}",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"linkUrl\": \"123131313\",\n        \"user\": \"123131313\",\n        \"pwd\": \"13131313\",\n        \"appid\": \"13131313\",\n        \"iframeUrl\": \"1313131313\",\n        \"auto_upload\": \"open\"\n    },\n    \"timestamp\": 1716546498679,\n    \"executeTime\": 14\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import log;
if (type == "save") { 
    var know = body.know
    var result = db.table('settings').primary('name').update({
        name: 'know',
        setting: know::stringify
    })
    if (result != null) {
        return know //原路返回
    }
} else { //获取列表
    var know = db.table("settings").where().eq("name", "know").selectOne()
    if (know != null && know.setting) {
        var result = know.setting::json
        return result
    }
    return []
}
return []
