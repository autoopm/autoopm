{
  "properties" : { },
  "id" : "9ebe9929409943c09805c4ee55943ac5",
  "script" : null,
  "groupId" : "7cc0839b044d4ab3a208aaf2142fbd7f",
  "name" : "退出共享",
  "createTime" : 1717060653330,
  "updateTime" : 1711870423933,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/share/out",
  "method" : "GET",
  "parameters" : [ {
    "name" : "id",
    "value" : "58",
    "description" : "\t 文件ID",
    "required" : true,
    "dataType" : "Integer",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": \"退出成功\",\n    \"timestamp\": 1711796619542,\n    \"executeTime\": 55\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import '@/file/updataShare' as updataShare;
import '@/file/permissionFind' as permissionFind;

//TODO 这里需要处理
// var userId = StpUtil.getLoginId()
var userId = '3';

// 验证权限
var file = permissionFind(id, userId, 0);

if (userId.equals(file.userid)) {
    exit 400, '不能退出自己共享的文件';
}

// 无法退出共享所有人的文件或文件夹
var num = db.table('file_users').where().eq('userid', -1).eq('file_id', file.id).count()
if (num > 0) {
    exit 400, '无法退出共享所有人的文件或文件夹';
}

db.transaction(() => {
    db.table('file_users')
        .where()
        .eq('file_id', file.id)
        .eq('userid', userId)
        .delete();
    // 同时删除成员分享的链接
    db.table('file_links')
        .where()
        .eq('file_id', file.id)
        .eq('userid', userId)
        .delete();
    updataShare(file);
});


return '退出成功';