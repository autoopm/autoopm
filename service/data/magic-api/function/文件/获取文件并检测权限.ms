{
  "properties" : { },
  "id" : "242dcf301d07402289536c41d9d35aee",
  "script" : null,
  "groupId" : "89c986b52b04478a95630c451428ab00",
  "name" : "获取文件并检测权限",
  "createTime" : 1716867163461,
  "updateTime" : 1713354709896,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/permissionFind",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ {
    "name" : "userId",
    "value" : null,
    "description" : "用户id",
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.Number",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "fileId",
    "value" : null,
    "description" : "文件id",
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.Number",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "limit",
    "value" : null,
    "description" : "期望的权限",
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.Number",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ]
}
================================
import cn.hutool.core.util.ObjectUtil
import cn.hutool.core.collection.CollUtil
import '@/file/getFileListByPermission' as getFileListByPermission
import log;
import java.util.LinkedHashMap;

// 先查文件是否存在
var num = db.table('files').where().eq('id', fileId).isNull('deleted_at').count()
if (num == 0) {
    exit 400, '文件不存在或已被删除';
}
// 验证权限
var file = getFileListByPermission(null, fileId, userId, null);
if (CollUtil.isEmpty(file)) {
    exit 400, '没有查看访问权限1';
}

log.info("file" + file)
log.info("file 0 " + file[0])
var permission = file[0].permission;
log.info("file 0 permission " + file[0].permission)
log.info(" limit--> " + limit)
if (permission == null) {
    exit 400, '没有查看访问权限2';
}

if (permission < limit) {
    if (limit == 1000) {
        exit 400, '仅限所有者或创建者操作';
    } else if (permission == 1) {
        exit 400, '没有修改写入权限';
    } else {
        exit 400, '没有查看访问权限3';
    }
}
log.info(" limit--> " + limit)
if (file.size() > 0) {
    return file[0];
} else {
    return null;
}
//返回第一个文件