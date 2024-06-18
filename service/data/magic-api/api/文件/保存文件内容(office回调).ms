{
  "properties" : { },
  "id" : "dc4859b433a248d2ab5b223735335641",
  "script" : null,
  "groupId" : "fbe74c5bc9f04c308679a525a09005a6",
  "name" : "保存文件内容(office回调)",
  "createTime" : null,
  "updateTime" : 1718326273872,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/content/office",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ {
    "name" : "require_login",
    "value" : "false",
    "description" : "该接口需要登录才允许访问",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import org.apache.tomcat.util.http.fileupload.FileUtils
import org.ssssssss.magicboot.utils.MinioUtil
import org.ssssssss.magicboot.utils.FileUtils
import cn.hutool.core.util.ObjectUtil;
import request;
import http;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import log;
import java.util.Scanner;
import response;
import java.net.HttpURLConnection;
import java.net.URL;
import cn.dev33.satoken.stp.StpUtil;
var userId = StpUtil.getLoginIdByToken(token)
// 查找文件
var file = db.table('files')
    .where()
    .isNull('deleted_at')
    .eq('id', id)
    .selectOne();

if (ObjectUtil.isEmpty(file)) {
    exit 400, '找不到相关文件'
}

// 如果状态为2，表示需要保存远程办公文档到本地服务器
if (body.status == 2) {
    URL url = new URL(body.url);
    HttpURLConnection connection = url.openConnection();
    InputStream stream = connection.getInputStream();

    var newUrl = MinioUtil.uploadStream(stream, '.' + file.ext);

    // 重新计算文件大小，更新文件大小
    var fileSize = FileUtils.getFileSize(MinioUtil.preview(newUrl));
    var content = {
        "url": newUrl
    }
    // 更新file_contents,没有就新增
    var isExist = db.table('file_contents').where().eq('fid', id).count();
    if (isExist > 0) {
        db.table('file_contents').primary('fid').update({
            fid: id,
            content: content::stringify,
            text: '',
            size: fileSize,
            userid: userId,
            updated_at: new Date()
        })
    } else {
        db.table('file_contents').primary('fid').insert({
            fid: id,
            content: content::stringify,
            text: '',
            size: fileSize,
            userid: userId,
            created_at: new Date(),
            updated_at: new Date()
        });
    }

    // 更新files
    db.table('files').primary('id').update({
        id: id,
        url: newUrl,
        size: fileSize,
        updated_at: new Date()
    })

}

return response.json({
    error: 0
});