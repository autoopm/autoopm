{
  "properties" : { },
  "id" : "545553628b37411aa66cdf6a8979e5c9",
  "script" : null,
  "groupId" : "7cc0839b044d4ab3a208aaf2142fbd7f",
  "name" : "添加或修改文件(夹)",
  "createTime" : 1716867156520,
  "updateTime" : 1716776108999,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/add",
  "method" : "GET",
  "parameters" : [ {
    "name" : "name",
    "value" : "测试文件3",
    "description" : "项目名称",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "type",
    "value" : "document",
    "description" : "文件类型",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "id",
    "value" : "0",
    "description" : "文件ID（赋值修改文件名称）",
    "required" : false,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "pid",
    "value" : "0",
    "description" : "父级ID",
    "required" : false,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "url",
    "value" : null,
    "description" : "文件url",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": \"添加成功\",\n    \"timestamp\": 1711943269761,\n    \"executeTime\": 4222\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import cn.hutool.core.util.ObjectUtil
import cn.hutool.core.util.StrUtil;
import '@/file/handleDuplicateName' as handleDuplicateName;
import '@/file/permissionFind' as permissionFind;
import 'cn.dev33.satoken.stp.StpUtil';
import log;

var userId = StpUtil.getLoginId();

String trimmedName = StrUtil.trim(name);
String trimmedType = StrUtil.trim(type);

if (trimmedName.length() < 2) {
    exit 400, '文件名称不可以少于2个字';
} else if (trimmedName.length() > 32) {
    exit 400, '文件名称最多只能设置32个字';
}

var tmpName = trimmedName.replaceAll("[\\\\/:*?\"<>|]", "");
if (!tmpName.equals(trimmedName)) {
    exit 400, '"文件名称不能包含这些字符：\/:*?\"<>|"';
}

if (id > 0) {
    // 修改
    var file = permissionFind(userId, id, 1);
    //  处理重名
    var newName = handleDuplicateName(pid, userId, ext, trimmedName);
    // 更新
    var result = {
        id: id,
        name: newName
    }
    db.table('files').primary('id').update(result);
    // todo 推送更新消息
    return result;
} else {
    // 添加
    if (![
            'folder',
            'document',
            'mind',
            'drawio',
            'word',
            'excel',
            'ppt',
        ].contains(trimmedType)) {
        exit 400, '类型错误';
    }

    var extMap = {
        'folder': null,
        'document': 'md',
        'mind': 'mind',
        'drawio': 'drawio',
        'word': 'docx',
        'excel': 'xlsx',
        'ppt': 'pptx',
    }
    var ext = extMap.get(trimmedType);
    if (pid > 0) {
        var fileNum = db.table("files")
            .where()
            .eq('pid', pid)
            .isNull('deleted_at')
            .count();
        if (fileNum > 300) {
            exit 400, '每个文件夹里最多只能创建300个文件或文件夹';
        }
        // 在文件夹里面创建的文件或者文件夹，所有者都是上一级文件夹的
        var file = permissionFind(userId, pid, 1);
        userId = file.userid;
    } else {
        var fileNum = db.table("files")
            .where()
            .eq('pid', 0)
            .isNull('deleted_at')
            .eq('userid', userId)
            .count();
        if (fileNum >= 300) {
            exit 400, '每个文件夹里最多只能创建300个文件或文件夹';
        }
    }

    //  处理重名
    var newName = handleDuplicateName(pid, userId, ext, trimmedName);
    var result = db.transaction(() => {
        var pshare = 0;
        // pid !=0才去看父级共享状态
        if (pid != 0) {
            var pfolder = db.table('files').where().isNull('deleted_at').eq('id', pid).selectOne();
            if (ObjectUtil.isNotEmpty(pfolder)) {
                if (pfolder.share == 1) {
                    // 如果父级是共享的，那么就把父级的id带过来
                    pshare = pfolder.id;
                } else if (pfolder.pshare != 0) {
                    // 如果父级的也是有pshare，那么就带过来
                    pshare = pfolder.pshare;
                }
            }
        }

        // 保存
        Date createdAt = new Date();
        var id = db.table('files')
            .primary('id')
            .insert({
                created_id: userId,
                name: newName,
                type: trimmedType,
                pid: pid,
                url: url,
                ext: ext,
                userid: userId,
                created_at: createdAt,
                updated_at: createdAt,
                pshare: pshare
            })
        // 更新 pids和id_path字段
        var pids = '';

        if (pid == 0) {
            pids = "/" + id + "/";
        } else {
            // 获取父级的pids
            var idPath = db.table('files')
                .where()
                .eq("id", pid)
                .isNull('deleted_at')
                .selectOne();
            pids = idPath.id_path + id + "/"
        }

        db.table('files').primary('id').update({
            id: id,
            pids: pids,
            id_path: pids
        })

        //TODO 插入文件用户表
        res = db.table("file_users").insert({
            file_id: id,
            userid: userId,
            permission: 1
        })
        log.info("插入文件用户表" + res)

        return result = {
            id: id,
            created_id: userId,
            name: newName,
            type: trimmedType,
            pid: pid,
            url: url,
            ext: ext,
            userid: userId,
            created_at: createdAt,
            updated_at: createdAt,
            deleted_at: null,
            pshare: pshare,
            pids: pids,
            id_path: pids
        };

    });

    // todo 发送添加成功消息
    return result;
}