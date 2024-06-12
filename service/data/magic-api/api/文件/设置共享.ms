{
  "properties" : { },
  "id" : "a61414d500be46b99f679ed4c8343413",
  "script" : null,
  "groupId" : "fbe74c5bc9f04c308679a525a09005a6",
  "name" : "设置共享",
  "createTime" : null,
  "updateTime" : 1718039286912,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/share/update",
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
  }, {
    "name" : "userids",
    "value" : null,
    "description" : "共享成员，格式: userid1, userid2, userid3(-1代表所有人)",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "permission",
    "value" : null,
    "description" : "共享方式  0：只读 1：读写 -1: 删除",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "force",
    "value" : null,
    "description" : "设置共享时是否忽略提醒  0：如果子文件夹已存在共享则ret返回-3001（默认） 1：忽略提醒",
    "required" : false,
    "dataType" : "String",
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
import org.apache.poi.hpsf.Date
import cn.hutool.core.util.StrUtil
import cn.hutool.core.util.ObjectUtil;
import '@/file/updataShare' as updataShare
import java.util.Date;
import 'cn.dev33.satoken.stp.StpUtil';

var userId = StpUtil.getLoginId()

if (![-1, 0, 1].contains(permission)) {
    exit 400, '参数错误';
}

var file = db.table('files')
    .where()
    .isNull(deleted_at)
    .eq('id', id)
    .selectOne();

if (ObjectUtil.isEmpty(file)) {
    exit 400, '文件不存在或已被删除';
}

if (ObjectUtil.isEmpty(userId) || userId.equals(file.userid)) {
    exit 400, '仅限所有者操作';
}
// 如果当前文件（夹）的父级文件已经被共享，那么当前文件（夹）无法重复共享
if (file.pshare != 0) {
    String fileTypeMessage = 'folder'.equals(file.type) ? '文件夹' : '文件';
    var pfolder = db.table('files')
        .where()
        .isNull(deleted_at)
        .eq('id', file.pshare)
        .selectOne();
    exit 400, "此" + fileTypeMessage + "已经处于【" + pfolder.name + "】共享文件夹中，无法重复共享";
}

if (StrUtil.isEmpty(userids)) {
    exit 400, '请选择共享对象';
}

if (-1 == permission) {
    // 取消某些人的共享,开启事务
    var val = db.transaction(() => {
        // 删除指定共享成员
        db.table('file_users')
            .where()
            .eq('file_id', file.id)
            .in('userid', StrUtil.split(userids, ','))
            .delete();
        // 同时删除成员分享的链接
        db.table('file_links')
            .where()
            .eq('file_id', file.id)
            .in('userid', StrUtil.split(userids, ','))
            .delete();
        updataShare(file);
    });
} else {
    // 设置共享
    // 此文件夹内已有共享文件夹,就不能共享了
    var isSubShare = db.select("""
    select EXISTS (
        select 1 from files 
        where id_path LIKE CONCAT(#{file.id_path}, '%') 
        and share = 1 
        and deleted_at is null
        and id <>#{id}
        ) as isSubShare
    """);

    if (isSubShare.isSubShare == 1) {
        exit - 3001, '此文件夹内已有共享文件夹';
    }

    // 共享人数上限100个成员
    var shareNum = db.table('file_users').where().eq('file_id', file.id).count() + StrUtil.split(userids, ',').size();
    if (shareNum > 100) {
        exit 400, '共享人数上限100个成员';
    }

    var val = db.transaction(() => {
        // 增加或者更新权限
        for (userid in StrUtil.split(userids, ',')) {
            var fileUser = db.table('file_users')
                .where()
                .eq('file_id', id)
                .eq('userid', userid)
                .selectOne();
            // 数据库有的就是更新，没有就是新增
            Date created = (ObjectUtil.isNull(fileUser) || ObjectUtil.isNull(fileUser.created_at) )? new Date() : fileUser.created_at;
            db.table('file_users')
                .primary('id')
                .save({
                    id: ObjectUtil.isNull(fileUser) ? null : fileUser.id,
                    file_id: file.id,
                    userid: userid,
                    permission: permission,
                    created_at: created
                });
        }
        updataShare(file);
    });
}

// todo 推送消息

return file;