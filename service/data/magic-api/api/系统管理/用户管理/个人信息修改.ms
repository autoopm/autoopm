{
  "properties" : { },
  "id" : "ebe40a0cf4b84192b6bbe923a0ecbd9c",
  "script" : null,
  "groupId" : "4f0230049d7e4f39b1e0897cc0f46f9a",
  "name" : "个人信息修改",
  "createTime" : 1646490239466,
  "updateTime" : 1643713357950,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/center/update",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ ],
  "requestBody" : "{\r\n\t\r\n}",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import cn.dev33.satoken.secure.SaSecureUtil;

var oldPassword = db.selectValue("""
    select password from sys_user where id = #{id}
""")
if(oldPassword != SaSecureUtil.sha256(password)){
    exit 0, '原密码不正确！'
}

var data = {
    id,
    phone,
    headPortrait
}
if(newPassword){
    data.password = newPassword ? SaSecureUtil.sha256(newPassword) : ''
}
return db.table('sys_user').primary('id').update(data, true)
