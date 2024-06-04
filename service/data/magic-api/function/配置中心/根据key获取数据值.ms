{
  "properties" : { },
  "id" : "3a21cd5fcd9b4e96b870a2268088266d",
  "script" : null,
  "groupId" : "7e31035eb8d4471b9fc2923ea1d966c3",
  "name" : "根据key获取数据值",
  "createTime" : null,
  "updateTime" : 1653119091752,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/getBykey",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ {
    "name" : "configureKey",
    "value" : null,
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.String",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ]
}
================================
var configure = db.cache(`configure:${configureKey}`).selectOne("""
     select configure_value from sys_configure where configure_key = #{configureKey}
""")
return configure == null ? "" : configure.get("configureValue")