{
  "properties" : { },
  "id" : "a5c13e62c60b46b0b485fd11a0f9c738",
  "script" : null,
  "groupId" : "fbe74c5bc9f04c308679a525a09005a6",
  "name" : "获取共享信息",
  "createTime" : null,
  "updateTime" : 1718035987087,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/share",
  "method" : "GET",
  "parameters" : [ {
    "name" : "id",
    "value" : null,
    "description" : "文件id",
    "required" : true,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "options" : [ ],
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
import cn.hutool.core.util.ObjectUtil;
import log;
import 'cn.dev33.satoken.stp.StpUtil';

var userId = StpUtil.getLoginId();

//文件复制
var file = db.table("files").where().eq("id",id).selectOne();
if (ObjectUtil.isEmpty(file)) {
    exit 400, '文件不存在或已被删除';
}
if(file.userid!=userId){
    exit 400, '仅限所有者操作';
}
var list = db.table("file_users").where().eq("file_id",id).select();
//返回的信息需要处理，暂时不知道怎么弄
var result = {}
result.id = file.id;
result.list = list;
return result;