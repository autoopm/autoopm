{
  "properties" : { },
  "id" : "1f383beed79b49a4a52fde4cce746c36",
  "script" : null,
  "groupId" : "fbe74c5bc9f04c308679a525a09005a6",
  "name" : "保存文件内容(上传文件)",
  "createTime" : null,
  "updateTime" : 1718155977780,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/content/upload",
  "method" : "POST",
  "parameters" : [ {
    "name" : "pid",
    "value" : "0",
    "description" : "父级ID",
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
  "responseBody" : "{\n    \"code\": 402,\n    \"message\": \"凭证已过期\",\n    \"data\": null,\n    \"timestamp\": 1717830457352,\n    \"executeTime\": null\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : {
    "name" : "",
    "value" : "",
    "description" : "",
    "required" : false,
    "dataType" : "Object",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "",
    "error" : "",
    "expression" : "",
    "children" : [ {
      "name" : "code",
      "value" : "402",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "message",
      "value" : "凭证已过期",
      "description" : "",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "data",
      "value" : "null",
      "description" : "",
      "required" : false,
      "dataType" : "Object",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "timestamp",
      "value" : "1717811802990",
      "description" : "",
      "required" : false,
      "dataType" : "Long",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "executeTime",
      "value" : "null",
      "description" : "",
      "required" : false,
      "dataType" : "Object",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    } ]
  }
}
================================
import cn.hutool.core.collection.CollUtil
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.io.FileUtil;
import com.alibaba.fastjson.JSONObject;
import cn.hutool.core.util.ObjectUtil;
import cn.dev33.satoken.stp.StpUtil;
import request;
import log;

import '@/file/permissionFind' as permissionFind;
import '@/file/getFileTypeByExt' as getFileTypeByExt;
import '@/file/handleDuplicateName' as handleDuplicateName;
import '@/file/uploadkb' as uploadkb;

import org.ssssssss.magicboot.utils.MinioUtil;
import org.ssssssss.magicboot.utils.FileUtils;

var userId = StpUtil.getLoginId();
log.info("文件上传的userid is->" + userId);
// var userId = 6;
var uploadFile = request.getFile('file')
log.info("uploadFile=" + uploadFile);
log.info("uploadFile.name" + uploadFile.name);
log.info("pid=" + pid);
pid = pid::int
log.info("pid----->" + pid);

if (pid > 0) {
    var fileNum = db.table("files").where().eq('pid', pid).isNull('deleted_at').count();
    if (fileNum > 300) {
        exit 400, '每个文件夹里最多只能创建300个文件或文件夹';
    }
    // 在文件夹里面创建的文件或者文件夹，所有者都是上一级文件夹的
    var file = permissionFind(userId, pid, 1);
    userId = file.userid;
} else {
    var fileNum = db.table("files").where().eq('pid', 0).isNull('deleted_at').eq('userid', userId).count();
    if (fileNum >= 300) {
        exit 400, '每个文件夹里最多只能创建300个文件或文件夹';
    }
}

// 单独传文件是webkitRelativePath是空的
log.info("webkitRelativePath={}", webkitRelativePath);
var dirs = StrUtil.isNotEmpty(webkitRelativePath) ? webkitRelativePath.split("/") : null;
log.info("dirs={}", dirs);
// 创建文件夹
while (dirs != null && dirs.length > 1) {
    // 获取数组的第一个元素
    var dirName = dirs[0];
    db.transaction(() => {
        // 检查文件夹是否存在，如果不存在则创建新文件夹。
        var dirRow = db.select("""
        SELECT * FROM files WHERE pid = #{pid} AND type = 'folder' AND name = #{dirName} and deleted_at is null FOR UPDATE
        """)

        if (CollUtil.isEmpty(dirRow)) {
            var newName = handleDuplicateName(pid, userId, null, dirName);
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

            var createdAt = new Date();

            log.info("pid={}", pid);
            // 保存
            var id = db.table('files')
                .primary('id')
                .insert({
                    created_id: userId,
                    name: newName,
                    type: 'folder',
                    pid: pid,
                    url: url,
                    ext: null,
                    userid: userId,
                    created_at: createdAt,
                    updated_at: createdAt,
                    pids: pids,
                    id_path: pids,
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
            // 如果文件夹不存在，抛出异常。
            if (null == id) {
                exit 400, '创建文件夹失败';
            }

            // 更新pid
            pid = id;

            //插入系统用户表,permission默认为1
            var id = db.table('file_users')
                .insert({
                    file_id: id,
                    created_at: createdAt,
                    updated_at: createdAt,
                    userid: userId,
                    permission: 1
                })



        } else {
            pid = dirRow.id;
        }
    });
    // 移除已经处理过的元素
    dirs = Arrays.copyOfRange(dirs, 1, dirs.length);
}

var fileNameWithExt = (dirs != null) ? dirs[0] : uploadFile.getOriginalFilename();
log.info("fileNameWithExt={}", fileNameWithExt);

int index = StrUtil.lastIndexOfIgnoreCase(fileNameWithExt, ".");
var ext = fileNameWithExt.substring(index + 1);
var fileName = fileNameWithExt.substring(0, index);

// 上传文件获取url
var fileUrl = MinioUtil.upload(uploadFile);
var url = MinioUtil.preview(fileUrl);
var fileType = getFileTypeByExt(ext);
var newName = handleDuplicateName(pid, userId, null, fileName);
var fileSize = FileUtils.getFileSize(url);

if ("markdown".equals(ext)) {
    ext = "md";
}

var result = {
    ret: 0
};
db.transaction(() => {
    log.info("pids-->-->-->-->-->-->-->-->-->-->" + pid)

    var pshare = 0;
    // pid !=0才去看父级共享状态
    if (pid != 0) {
        var pfolder = db.table('files').where().isNull('deleted_at').eq('id', pid).eq('share', 1).selectOne();
        pshare = (pfolder != null && 1 == pfolder.share) ? pfolder.id : 0;
    }
    // 保存
    var createdAt = new Date();
    var id = db.table('files')
        .primary('id')
        .insert({
            created_id: userId,
            name: newName,
            type: fileType,
            pid: pid,
            url: fileUrl,
            ext: ext,
            userid: userId,
            created_at: createdAt,
            updated_at: createdAt,
            pshare: pshare,
            size: fileSize
        })
    // 更新 pids和id_path字段
    var pids = '';

    if (pid == 0 || pid == '0') { //特殊处理了
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

    //插入系统用户表,permission默认为1
    var file_users = db.table('file_users')
        .insert({
            file_id: id,
            created_at: createdAt,
            updated_at: createdAt,
            userid: userId,
            permission: 1
        })

    var content = {
        'from': '',
        'type': fileType,
        'ext': ext,
        'url': fileUrl
    }
    // 新增fileContent
    var fileContentMap = {
        fid: id,
        content: JSONObject.toJSONString(content),
        text: text,
        size: fileSize,
        userid: userId,
        created_at: createdAt,
        updated_at: createdAt
    }

    db.table('file_contents')
        .primary('id', null)
        .save(fileContentMap);

    //TODO 调用函数上传知识库,暂时不考虑上传
    // uploadkb(fileUrl)
    result = {
        id: id,
        created_id: userId,
        name: newName,
        type: fileType,
        pid: pid,
        ext: ext,
        userid: userId,
        created_at: createdAt,
        updated_at: createdAt,
        deleted_at: null,
        pshare: pshare,
        pids: pids,
        id_path: pids,
        size: fileSize,
        ret: 1
    }
    if ("picture".equals(fileType)) {
        result.put('image_url', 'http://82.157.62.190:8081/api/file/preview/' + id);
    }

});

return result;