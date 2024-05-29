{
  "properties" : { },
  "id" : "d36f1163b6e54a98a9239c115008050b",
  "script" : null,
  "groupId" : "95e5c1dbf9144c9590e70cc8b304f1a2",
  "name" : "删除部门-待测试更多",
  "createTime" : 1716867158305,
  "updateTime" : 1713325132710,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/del",
  "method" : "GET",
  "parameters" : [ {
    "name" : "id",
    "value" : "25",
    "description" : "部门id",
    "required" : true,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : "部门id必填",
    "expression" : "value > 0 ",
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 400,\n    \"message\": \"部门不存在或已被删除\",\n    \"data\": null,\n    \"timestamp\": 1708509216081,\n    \"executeTime\": 3\n}",
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
      "children" : [ ]
    }, {
      "name" : "timestamp",
      "value" : "1708506507334",
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
      "value" : "13",
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
//TODO 判断当前用户是否是管理员 
import log
import '@/users/deleteDepartment' as deleteDepartment

log.info("这里1")
depart = db.table("user_departments").where().eq("id", id).selectOne()
if (depart != null) {
    deleteDepartment(id)
    log.info("这里2")
    // //删除子部门
    // list = db.table("user_departments").where().eq("parent_id", id).select()
    // if (list.size() > 0) {
    //     log.info("这里3")
    //     for (item in list) {
    //         deleteDepartment(item.id)
    //     }
    // }
    return []
} else {
    exit 400, '部门不存在或已被删除';
}