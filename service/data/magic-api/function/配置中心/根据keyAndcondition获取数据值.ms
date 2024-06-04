{
  "properties" : { },
  "id" : "copy1653111178446d65648",
  "script" : null,
  "groupId" : "7e31035eb8d4471b9fc2923ea1d966c3",
  "name" : "根据keyAndcondition获取数据值",
  "createTime" : null,
  "updateTime" : 1653118303409,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/getBykeyCondition",
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
  }, {
    "name" : "configureCondition",
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
var configure = db.cache(`configure:${configureKey}${configureCondition}`).selectOne("""
     select configure_value from sys_configure where configure_key = #{configureKey} 
     ?{configureCondition, and configure_condition = #{configureCondition}}
""")

return configure == null ? "" : configure.get("configureValue")