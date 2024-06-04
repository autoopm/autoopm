{
  "properties" : { },
  "id" : "c97e92eef5024994a32352cddbe73d6d",
  "script" : null,
  "groupId" : "1952f25c81084e24b55b11385767dc38",
  "name" : "获取当前用户权限code",
  "createTime" : null,
  "updateTime" : 1646544829355,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/permissions",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ ],
  "requestBody" : "{\n\n}",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": [\"menu:view\", \"menu:save\", \"menu:delete\", \"office:save\", \"office:delete\", \"role:save\", \"role:delete\", \"role:permission\", \"user:save\", \"user:delete\", \"dict:save\", \"dict:delete\", \"dict:items:save\", \"dict:items:delete\", \"office:view\", \"role:view\", \"user:view\", \"dict:view\", \"dict:items:view\"],\n    \"timestamp\": 1645715342825,\n    \"executeTime\": 2\n}",
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
        "value" : "menu:view",
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
      "value" : "1645715342825",
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
      "dataType" : "Object",
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
import 'cn.dev33.satoken.stp.StpUtil';

var userId = StpUtil.getLoginId()
return db.cache(`permissions:${userId}`).select("""
    SELECT DISTINCT
        sm.permission
    FROM
        sys_menu sm
        ?{userId != '1', 
            right JOIN sys_role_menu srm ON sm.id = srm.menu_id
            right JOIN sys_user_role sur ON sur.role_id = srm.role_id
            right JOIN sys_user su ON su.id = sur.user_id
            AND su.id = #{userId} AND su.is_del = 0
        }
    WHERE
        sm.is_del = 0
        AND sm.permission != ''
        AND sm.permission IS NOT NULL
""").map((it) => {return it.permission})