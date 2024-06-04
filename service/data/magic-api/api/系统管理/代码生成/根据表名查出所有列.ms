{
  "properties" : { },
  "id" : "98367deee5714ede88c1e134b16bebeb",
  "script" : null,
  "groupId" : "f2538e0f370a4cabab0ae920f5e77ae7",
  "name" : "根据表名查出所有列",
  "createTime" : null,
  "updateTime" : 1654682348773,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/columns",
  "method" : "GET",
  "parameters" : [ {
    "name" : "tableName",
    "value" : "sys_user",
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
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"columns\": [{\n            \"columnName\": \"username\",\n            \"columnComment\": \"登录名\",\n            \"dataType\": \"varchar\",\n            \"required\": 1\n        }, {\n            \"columnName\": \"name\",\n            \"columnComment\": \"姓名/昵称\",\n            \"dataType\": \"varchar\",\n            \"required\": 0\n        }, {\n            \"columnName\": \"password\",\n            \"columnComment\": \"密码\",\n            \"dataType\": \"varchar\",\n            \"required\": 0\n        }, {\n            \"columnName\": \"status\",\n            \"columnComment\": \"状态\",\n            \"dataType\": \"char\",\n            \"required\": 0\n        }, {\n            \"columnName\": \"phone\",\n            \"columnComment\": \"手机号\",\n            \"dataType\": \"varchar\",\n            \"required\": 0\n        }, {\n            \"columnName\": \"head_portrait\",\n            \"columnComment\": \"头像\",\n            \"dataType\": \"varchar\",\n            \"required\": 0\n        }, {\n            \"columnName\": \"is_login\",\n            \"columnComment\": \"禁止登录：0未禁用，1已禁用\",\n            \"dataType\": \"int\",\n            \"required\": 0\n        }, {\n            \"columnName\": \"sort\",\n            \"columnComment\": \"排序\",\n            \"dataType\": \"int\",\n            \"required\": 0\n        }, {\n            \"columnName\": \"office_id\",\n            \"columnComment\": \"组织机构id\",\n            \"dataType\": \"varchar\",\n            \"required\": 0\n        }],\n        \"primary\": \"id\"\n    },\n    \"timestamp\": 1648312726132,\n    \"executeTime\": 12\n}",
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
        "name" : "columns",
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
            "name" : "columnName",
            "value" : "username",
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
            "name" : "columnComment",
            "value" : "登录名",
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
            "name" : "dataType",
            "value" : "varchar",
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
            "name" : "required",
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
          } ]
        } ]
      }, {
        "name" : "primary",
        "value" : "id",
        "description" : "",
        "required" : false,
        "dataType" : "String",
        "type" : null,
        "defaultValue" : null,
        "validateType" : "",
        "error" : "",
        "expression" : "",
        "children" : [ ]
      } ]
    }, {
      "name" : "timestamp",
      "value" : "1648312726132",
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
      "value" : "12",
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
return {
    columns: db[datasource || ''].select("""
        SELECT
            column_name,
            column_comment,
            column_type,
            case when is_nullable = 'YES' then 0 else 1 end required
        FROM
            information_schema.COLUMNS 
        WHERE
            table_name = #{tableName}
            AND column_name NOT IN ( 'id', 'is_del', 'create_by', 'create_date', 'update_by', 'update_date' ) 
            AND table_schema = DATABASE()
    """),
    primary: db.selectValue("SELECT column_name FROM information_schema.COLUMNS WHERE table_name = #{tableName} and column_key = 'PRI' and table_schema = database() limit 1")
}