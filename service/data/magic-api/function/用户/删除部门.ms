{
  "properties" : { },
  "id" : "61c1402b5fa541909f145cf307e8052a",
  "script" : null,
  "groupId" : "29554e07436d4c1396420cbfedd40cd9",
  "name" : "删除部门",
  "createTime" : 1717060654075,
  "updateTime" : 1713024595444,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/deleteDepartment",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ {
    "name" : "id",
    "value" : null,
    "description" : "部门id",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ]
}
================================
  import log
  import '@/users/deleteDepartment' as deleteDepartment
  log.info("传进来的项目id" + id)

  list = db.table("user_departments").where().eq("parent_id", id).select()
  if (list.size() > 0) {
      for (item in list) {
          //TODO 遍历出自己的 
          deleteDepartment(item.id)
      }
  }
  //查找哪些用户在部门中
  userList = db.select("""
        SELECT * FROM users WHERE department like '%,${id},%'
    """)

  log.info("userList size " + userList.size())
  //用户的部门信息字段移除删除的部门id
  for (item in userList) {
      log.info("userList item" + item)
      db.update("""
        UPDATE users SET department = CONCAT(',', TRIM(BOTH ',' FROM REPLACE(CONCAT(',', department, ','), ',${id},', ',')), ',') WHERE department LIKE '%,${id},%'
        """)
  }
  //删除部门
  result = db.table("user_departments").where().eq("id", id).delete()
  log.info("删除部门返回结果-->" + result)
  //TODO 解散群组
  return result