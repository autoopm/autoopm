{
  "properties" : { },
  "id" : "8ab83155b63042a58a6a76a566c5575a",
  "script" : null,
  "groupId" : "fbe74c5bc9f04c308679a525a09005a6",
  "name" : "退出共享",
  "createTime" : null,
  "updateTime" : 1718039189737,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/share/out",
  "method" : "GET",
  "parameters" : [ {
    "name" : "id",
    "value" : null,
    "description" : "文件ID",
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
  "responseBody" : null,
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