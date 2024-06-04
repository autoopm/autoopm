{
  "properties" : { },
  "id" : "c01db2a3b18246c89ef1a6ad6b39342c",
  "script" : null,
  "groupId" : "6f106ebdee21489db34b956f7770ff03",
  "name" : "保存tree",
  "createTime" : null,
  "updateTime" : 1712742368621,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/save/tree",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ {
    "name" : "permission",
    "value" : "component:save:tree",
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
let data
if(id){
    data = {id, name}
    if(type == '1'){
        if(db.selectInt("select count(1) from sys_dynamic_component where is_del = 0 and type = 1 and name = #{name} and id != #{id}") > 0){
            exit 0, '组件名称不能重复'
        }
    }else{
        if(
            db.selectInt("""
                select count(1) from sys_dynamic_component where is_del = 0 and type = 0
                and pid = (select pid from sys_dynamic_component where is_del = 0 and id = #{id}) and name = #{name} and id != #{id}
            """) > 0
            ){
            exit 0, '当前分组下已存在相同分组名称'
        }
    }
}else{
    data = {pid, name}
    if(type == '1'){
        if(db.selectInt("select count(1) from sys_dynamic_component where is_del = 0 and type = 1 and name = #{name}") > 0){
            exit 0, '组件名称不能重复'
        }
    }else{
        if(db.selectInt("select count(1) from sys_dynamic_component where is_del = 0 and type = 0 and pid = #{pid} and name = #{name}") > 0){
            exit 0, '当前分组下已存在相同分组名称'
        }
    }
}
data.type = type
data.remark = remark
return db.table("sys_dynamic_component").primary("id").withBlank().saveOrUpdate(data)