{
  "properties" : { },
  "id" : "bcdc82d0048644398e76f5e5a5d88d23",
  "script" : null,
  "groupId" : "7cc0839b044d4ab3a208aaf2142fbd7f",
  "name" : "复制文件(夹)",
  "createTime" : 1716867156311,
  "updateTime" : 1716517452091,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/copy",
  "method" : "GET",
  "parameters" : [ {
    "name" : "id",
    "value" : "13",
    "description" : "文件ID",
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
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": 0,\n    \"timestamp\": 1711036551973,\n    \"executeTime\": 2\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : {
    "name" : "",
    "value" : "",
    "description" : "",
    "required" : false,
    "dataType" : "Object",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "",
    "error" : "",
    "expression" : "",
    "children" : [ {
      "name" : "code",
      "value" : "200",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "message",
      "value" : "success",
      "description" : "",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "data",
      "value" : "",
      "description" : "",
      "required" : false,
      "dataType" : "Array",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ {
        "name" : "",
        "value" : "",
        "description" : "",
        "required" : false,
        "dataType" : "Object",
        "type" : null,
        "defaultValue" : null,
        "validateType" : "",
        "error" : "",
        "expression" : "",
        "children" : [ {
          "name" : "id",
          "value" : "16",
          "description" : "",
          "required" : false,
          "dataType" : "Integer",
          "type" : null,
          "defaultValue" : null,
          "validateType" : "",
          "error" : "",
          "expression" : "",
          "children" : [ ]
        }, {
          "name" : "file_id",
          "value" : "19",
          "description" : "",
          "required" : false,
          "dataType" : "Integer",
          "type" : null,
          "defaultValue" : null,
          "validateType" : "",
          "error" : "",
          "expression" : "",
          "children" : [ ]
        }, {
          "name" : "userid",
          "value" : "1",
          "description" : "",
          "required" : false,
          "dataType" : "Integer",
          "type" : null,
          "defaultValue" : null,
          "validateType" : "",
          "error" : "",
          "expression" : "",
          "children" : [ ]
        }, {
          "name" : "permission",
          "value" : "0",
          "description" : "",
          "required" : false,
          "dataType" : "Integer",
          "type" : null,
          "defaultValue" : null,
          "validateType" : "",
          "error" : "",
          "expression" : "",
          "children" : [ ]
        }, {
          "name" : "created_at",
          "value" : "null",
          "description" : "",
          "required" : false,
          "dataType" : "Object",
          "type" : null,
          "defaultValue" : null,
          "validateType" : "",
          "error" : "",
          "expression" : "",
          "children" : [ ]
        }, {
          "name" : "updated_at",
          "value" : "null",
          "description" : "",
          "required" : false,
          "dataType" : "Object",
          "type" : null,
          "defaultValue" : null,
          "validateType" : "",
          "error" : "",
          "expression" : "",
          "children" : [ ]
        } ]
      } ]
    }, {
      "name" : "timestamp",
      "value" : "1711035730814",
      "description" : "",
      "required" : false,
      "dataType" : "Long",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "executeTime",
      "value" : "2",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    } ]
  }
}
================================
import org.junit.jupiter.params.provider.NullAndEmptySource
import 'cn.dev33.satoken.stp.StpUtil'; 
import log;
//TODO 这里需要处理
//var userId = StpUtil.getLoginId();
var userId = 6;
//根据文件id和userid去file_users表查询，是否有复制权限
 var fileUsers = db.table("file_users").where().eq("file_id",id).eq("userid",userId).select();
 if(fileUsers.size() ==0){
    exit '没有找到可以复制的文件'
 }
//文件复制
var fileCopy = db.table("files").where().eq("id",id).selectOne();
//插入的数据 
var data = {}
data.pid=fileCopy.pid;
data.id_path=fileCopy.id_path;
data.url=fileCopy.url;
data.pids=fileCopy.pids;
data.cid=fileCopy.cid;
data.name=fileCopy.name;
data.type=fileCopy.type;
data.ext=fileCopy.ext;
data.size=fileCopy.size;
data.userid=fileCopy.userid;
data.share=fileCopy.share;
data.pshare=fileCopy.pshare;
data.created_id=fileCopy.created_id;
data.created_at=fileCopy.created_at;
data.updated_at=fileCopy.updated_at;
data.deleted_at=fileCopy.deleted_at;
//插入操作
var file = db.table("files").insert(data);
return file