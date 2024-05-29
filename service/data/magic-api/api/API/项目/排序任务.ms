{
  "properties" : { },
  "id" : "e6ef7fe6cf5942c980581044e77a5dff",
  "script" : null,
  "groupId" : "0c2d9f4051a44b37a9a0f361f4e13b75",
  "name" : "排序任务",
  "createTime" : 1716867159445,
  "updateTime" : 1713325102555,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/sort",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ ],
  "requestBody" : "{\n  \"project_id\": 94,\n  \"sort\": [\n    {\n      \"id\": 133,\n      \"task\": []\n    },\n    {\n      \"id\": 134,\n      \"task\": [\n        135\n      ]\n    }\n  ],\n  \"only_column\": 0\n}",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": [],\n    \"timestamp\": 1712569802656,\n    \"executeTime\": 16\n}",
  "description" : null,
  "requestBodyDefinition" : {
    "name" : "root",
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
      "name" : "project_id",
      "value" : "92",
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
      "name" : "sort",
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
          "value" : "126",
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
          "name" : "task",
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
            "value" : "125",
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
        } ]
      } ]
    }, {
      "name" : "only_column",
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
    } ]
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
      "value" : "1712563007008",
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
      "value" : "3",
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

var useProject = db.table("projects").where().eq("id", body.project_id).isNull("archived_at").selectOne()
if (useProject == null) {
    exit 400, '项目不存在或已归档'
}

if (only_column) { //仅仅有默认列表 TODO 遇到再测试
    for (item in body.sort) {
        indexSort = 0
        log.info('item value' + item)
        // if (item.task.size() > 0) {
        // for (item2 in item.task) {
        log.info('item2 value' + item2)
        result = db.update("""
        UPDATE project_tasks SET sort = #{indexSort}  WHERE id = #{item.id}  and project_id = #{body.project_id}
        """)
        log.info("update result " + result)
        //父任务先不管
        indexSort++
        // }
        // }

    }
    return []

} else {
    for (item in body.sort) {
        indexSort = 0
        log.info('item value' + item)
        if (item.task.size() > 0) {
            for (item2 in item.task) {
                log.info('item2 value' + item2)
                result = db.update("""
        UPDATE project_tasks SET sort = #{indexSort} ,column_id = #{item.id}  WHERE id = #{item2}  and project_id = #{body.project_id} and complete_at is null
        """)
                log.info("update result " + result)
                //父任务先不管
                indexSort++
            }
        }
    }
    return []
}