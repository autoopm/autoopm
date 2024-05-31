{
  "properties" : { },
  "id" : "0cda503c44174e67a0b8a12e290944fd",
  "script" : null,
  "groupId" : "95e5c1dbf9144c9590e70cc8b304f1a2",
  "name" : "新建和修改部门",
  "createTime" : 1717060653676,
  "updateTime" : 1713325130975,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/add",
  "method" : "GET",
  "parameters" : [ {
    "name" : "id",
    "value" : "0",
    "description" : "部门id，留空为创建部门",
    "required" : false,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "name",
    "value" : "测试部门22231332423424",
    "description" : "部门名称",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "parent_id",
    "value" : "27",
    "description" : "上级部门ID",
    "required" : false,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : "0",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "owner_userid",
    "value" : "1",
    "description" : "部门负责人ID",
    "required" : false,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : "0",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "dialog_group",
    "value" : "new",
    "description" : "部门群（仅创建部门时有效）new: 创建（默认）use: 使用现有群",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "dialog_useid",
    "value" : "",
    "description" : "使用现有群ID（dialog_group=use时有效）",
    "required" : false,
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"id\": 49,\n        \"name\": \"测试部门22231332423424\",\n        \"dialog_id\": 0,\n        \"parent_id\": 27,\n        \"owner_userid\": 1,\n        \"created_at\": null,\n        \"updated_at\": null\n    },\n    \"timestamp\": 1708957472947,\n    \"executeTime\": 17\n}",
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
      "dataType" : "Object",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ {
        "name" : "id",
        "value" : "49",
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
        "name" : "name",
        "value" : "测试部门22231332423424",
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
        "name" : "dialog_id",
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
        "name" : "parent_id",
        "value" : "27",
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
        "name" : "owner_userid",
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
    }, {
      "name" : "timestamp",
      "value" : "1708957472947",
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
      "value" : "17",
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
import log

if (name.length() < 2 || name.length() > 20) {
    exit 400, '部门名称长度限制2-20个字';
}
//TODO 特殊字符不允许出现
var userDepartment
if (id != 0) {
    userDepartment = db.table("user_departments").where().eq("id", id).selectOne()
    if (userDepartment == null) {
        exit 400, '部门不存在或已被删除';
    }
    if (userDepartment.size() > 200) {
        exit 400, '最多只能创建200个部门';
    }
}

log.info("parent_id::" + parent_id)
//判断上级部门
if (parent_id !== null && parent_id > 0) {
    parentDepartment = db.table("user_departments").where().eq("id", parent_id).selectOne()

    if (parentDepartment == null) {
        exit 400, '上级部门不存在或已被删除';
    }

    if (parentDepartment.parent_id > 0) {
        exit 400, '上级部门层级错误';
    }
    //查找有多少个同是父部门的
    departments = db.table("user_departments").where().eq("parent_id", parent_id).select()

    if (departments != null && departments.size() > 20) {
        exit 400, '每个部门最多只能创建20个子部门';
    }
    
    departments = db.table("user_departments").where().eq("parent_id", id).select()
    if (id > 0 && departments != null) {
        exit 400, '含有子部门无法修改上级部门';
    }
}

log.info("parent_id::" + parent_id)
log.info("owner_userid::" + owner_userid)

// !User::whereUserid($owner_userid)->exists() TODO 这个没看懂什么意思
if (owner_userid == 0) {
    exit 400, '请选择正确的部门负责人';
}

if (userDepartment != null) { //保存操作
    var result = db.table("user_departments").primary("id").update({
        id: id,
        name: name,
        parent_id: parent_id,
        owner_userid: owner_userid
    })
    log.info("更新部门" + result)
    return db.table("user_departments").where().eq("id", id).selectOne()
    // return result
} else { //新建操作
    var result = db.table("user_departments").insert({
        name: name,
        parent_id: parent_id,
        owner_userid: owner_userid
    })

    log.info("新建部门" + result)
    return db.table("user_departments").where().eq("id", result).selectOne()
}