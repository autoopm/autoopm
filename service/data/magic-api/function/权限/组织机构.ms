{
  "properties" : { },
  "id" : "a5f80b11b7fb4f3c97252331c80bcf85",
  "script" : null,
  "groupId" : "41922e26ef57421f8819fe6c59f14d63",
  "name" : "组织机构",
  "createTime" : 1646490239535,
  "updateTime" : 1642327198030,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/office",
  "description" : null,
  "returnType" : null,
  "mappingPath" : "/permission/office",
  "parameters" : [ ]
}
================================
import 'cn.dev33.satoken.stp.StpUtil';

var currentUserId = StpUtil.getLoginId()
//查出当前用户有多少角色
var roles = db.select("""
    select permission from sys_role where is_del = 0 and id in (select role_id from sys_user_role where user_id = #{currentUserId})
""")
var userIds = []
for(role in roles){
    if(role.permission == '0'){
        return []
    }else if(role.permission == '1'){
        userIds.addAll(db.select("""
            select id from sys_user where is_del = 0 and office_id in (
                select office_id from sys_role_office where role_id in (
                    select role_id from sys_user_role where user_id = #{currentUserId}
                )
            )
        """).map(it => it.id))
    }else{
        var officeId = db.selectValue("select office_id from sys_user where id = #{currentUserId}")
        var offices = []
        offices.push(officeId)
        var getOfficeId = (list,pid) => {
            var ids = select t.id from list t where t.pid = pid;
            for(it in ids){
                offices.push(it.id)
                getOfficeId(list,it.id)
            }
        }
        getOfficeId(db.select('select id, pid from sys_office where is_del = 0 order by sort'),officeId)
        userIds.addAll(db.select("select id from sys_user where office_id in (#{offices})").map(it => it.id))
    }
}

return userIds