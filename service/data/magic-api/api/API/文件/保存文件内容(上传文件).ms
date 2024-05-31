{
  "properties" : { },
  "id" : "63db3582e2954c7db94e36626fffa1de",
  "script" : null,
  "groupId" : "7cc0839b044d4ab3a208aaf2142fbd7f",
  "name" : "保存文件内容(上传文件)",
  "createTime" : 1717060652958,
  "updateTime" : 1717056473409,
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
    "expression" : "",
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 500,\n    \"message\": \"系统内部出现错误\",\n    \"data\": null,\n    \"timestamp\": 1716879514327,\n    \"executeTime\": 85\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import cn.hutool.core.collection.CollUtil
import cn.hutool.core.util.StrUtil;
import '@/file/permissionFind' as permissionFind;
import cn.hutool.core.util.StrUtil;
import '@/file/getFileTypeByExt' as getFileTypeByExt;
import '@/file/handleDuplicateName' as handleDuplicateName;
import org.ssssssss.magicboot.utils.MinioUtil;
import cn.hutool.core.io.FileUtil;
import org.ssssssss.magicboot.utils.FileUtils;
import com.alibaba.fastjson.JSONObject;
import cn.hutool.core.util.ObjectUtil;
import 'cn.dev33.satoken.stp.StpUtil';
import request;
import log;
import '@/file/uploadkb' as uploadkb;
import env

var serviceUrl = env.get("public.domain") + ":" + env.get("server.port")
log.info("serviceUrl-->" + serviceUrl);


var userId = StpUtil.getLoginId();
// var userId = 6;

var uploadFile = request.getFile('file')

log.info("uploadFile={}", uploadFile);
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

    //TODO 调用函数上传知识库
    uploadkb(fileUrl)

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
        result.put('image_url', serviceUrl + '/api/file/preview/' + id);
    }

});

return result;