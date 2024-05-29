{
  "properties" : { },
  "id" : "4ec2689bd2f14c24842d9cd1f02531ce",
  "script" : null,
  "groupId" : "7cc0839b044d4ab3a208aaf2142fbd7f",
  "name" : "获取链接",
  "createTime" : 1716867157352,
  "updateTime" : 1716521617975,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/link",
  "method" : "GET",
  "parameters" : [ {
    "name" : "id",
    "value" : null,
    "description" : "文件ID",
    "required" : true,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "refresh",
    "value" : null,
    "description" : "刷新链接  no: 只获取（默认） yes: 刷新链接，之前的将失效",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "no",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 400,\n    \"message\": \"参数[id]为必填项\",\n    \"data\": null,\n    \"timestamp\": 1711468246717,\n    \"executeTime\": 0\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import 'cn.dev33.satoken.stp.StpUtil';
import '@/file/permissionFind' as permissionFind;
import log;
//TODO 这里需要处理
//var userId = StpUtil.getLoginId();
var userId = 0;

// 权限校验
var file = permissionFind(id, userId, 0);
if ("folder".equals(file.type)) {
    exit 400, '文件夹不支持分享';
}

// var fileLinks = db.table("file_links").where().eq("userid", userId).select();
// var result = {};
// result.fileLinks = fileLinks;
return result;