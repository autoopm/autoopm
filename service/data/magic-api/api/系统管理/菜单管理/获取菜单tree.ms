{
  "properties" : { },
  "id" : "ffb6988226d14e6789cc30193e008183",
  "script" : null,
  "groupId" : "67b2ce258e24491194b74992958c74aa",
  "name" : "获取菜单tree",
  "createTime" : null,
  "updateTime" : 1709801228981,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/tree",
  "method" : "GET",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "menu:view",
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
  "responseBody" : "{\n    \"code\": 402,\n    \"message\": \"凭证已过期\",\n    \"data\": null,\n    \"timestamp\": 1709773777522,\n    \"executeTime\": null\n}",
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
      "value" : "402",
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
      "value" : "凭证已过期",
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
      "value" : "1634309660370",
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
  }
}
================================
var toTree = (list,pid) => select t.*,toTree(list,t.id) children from list t where t.pid = pid
var list = toTree(db.select("""
    select 
        sm.id,
        sm.name,
        sm.pid,
        sm.is_show, 
        sm.url,
        sm.sort,
        sm.permission,
        sm.desc_ribe,
        sm.icon,
        sm.keep_alive,
        sdc.name component_name,
        sm.component_id,
        sm.open_mode 
    from sys_menu sm left join sys_dynamic_component sdc on sm.component_id = sdc.id
    where sm.is_del = 0 order by sm.sort
"""),'0')

return {
    list: list,
    total: list.getLength()
}