{
  "properties" : { },
  "id" : "8ba14d61082e4ba69324fdc9de080f38",
  "script" : null,
  "groupId" : "6f106ebdee21489db34b956f7770ff03",
  "name" : "获取组件tree",
  "createTime" : null,
  "updateTime" : 1712742831654,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/tree",
  "method" : "GET",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "component:tree",
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
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
var toTree = (list,pid) => select t.*,toTree(list,t.id) children from list t where t.pid = pid
var list = toTree(db.select("""
    select 
        dc.id,
        (case when dc.remark is not null and dc.remark != '' then concat(dc.name,'(',dc.remark, ')') else dc.name end) name,
        dc.pid,
        (case when dc.type = 0 then 1 else 0 end) is_group
    from sys_dynamic_component dc
    where dc.is_del = 0 
    order by dc.name
"""),'0')

return {
    list: list,
    total: list.getLength()
}