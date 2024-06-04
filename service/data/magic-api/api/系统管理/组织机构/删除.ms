{
  "properties" : { },
  "id" : "4f2140a0d177450da2f27e4569afb7b8",
  "script" : null,
  "groupId" : "8295fc13678d4144bf7363c465247a50",
  "name" : "删除",
  "createTime" : null,
  "updateTime" : 1679552802807,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/delete",
  "method" : "DELETE",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "office:delete",
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
  "requestBody" : "{\n\n}",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": null,\n    \"timestamp\": 1641201245421,\n    \"executeTime\": 7\n}",
  "description" : null,
  "requestBodyDefinition" : {
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
    "children" : [ ]
  },
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
      "name" : "timestamp",
      "value" : "1641201245421",
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
      "value" : "7",
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
var pCount = db.selectInt("select count(1) from sys_office where is_del = 0 and pid = #{id}")
if(pCount > 0){
    exit 500,'存在下级机构,不允许删除'
}
var userCount = db.selectInt("select count(1) from sys_user where is_del = 0 and office_id = #{id}")
if(userCount > 0){
    exit 500, '机构存在用户,不允许删除'
}
// var root = db.selectValue("select pid from sys_office where is_del = 0 and id = #{id}")
// if(root == '0'){
//     exit 500, '不能删除根节点'
// }
// db.table('sys_user_office').where().eq("office_id",id).delete();
return db.table("sys_office").logic().where().eq("id",id).delete();
