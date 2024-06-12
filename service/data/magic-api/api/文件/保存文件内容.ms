{
  "properties" : { },
  "id" : "990c56d25e114498b78c82a18e183f8f",
  "script" : null,
  "groupId" : "fbe74c5bc9f04c308679a525a09005a6",
  "name" : "保存文件内容",
  "createTime" : null,
  "updateTime" : 1718100882862,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/content/save",
  "method" : "POST",
  "parameters" : [ {
    "name" : "id",
    "value" : null,
    "description" : "文件ID",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "content",
    "value" : null,
    "description" : "Request Payload 提交  content: 内容",
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
import cn.hutool.core.util.ObjectUtil
import log;
import org.ssssssss.magicboot.utils.MinioUtil
import cn.hutool.core.io.FileUtil;
import org.ssssssss.magicboot.utils.FileUtils;
import cn.hutool.core.util.StrUtil;
import cn.hutool.http.HtmlUtil;
import '@/file/permissionFind' as permissionFind;
import java.io.InputStream;
import cn.dev33.satoken.stp.StpUtil;

// var userId = 6
var userId = StpUtil.getLoginId()
var id = body.id;
var content = body.content::json
log.info("content is " + content);
// 根据文件ID和用户权限查找文件实例
var file = permissionFind(userId, id, 1);
log.info("save permissionFind file--->" + file)

// 初始化文本变量
var text = '';

// var contentJsonObject = content::json
// log.info("contentJsonObject id",contentJsonObject)
var contentString = '';
var ext = '';

// 如果文件类型为文档
if ('document'.equals(file.type)) {
    // 移除内容中HTML标签，仅保留文本
    text = HtmlUtil.cleanHtmlTag(content);
}

// 根据文件类型处理内容
if ('document'.equals(file.type)) {
    // 处理文档类型文件
    contentString = content;
    // 设置文件扩展名
    ext = 'md'.equals(content.type) ? 'md' : 'text';
} else if ('drawio'.equals(file.type)) {
    // 处理绘图类型文件
    contentString = content.xml;
    // 设置文件扩展名
    ext = 'drawio';
} else if ('mind'.equals(file.type)) {
    contentString = content;
    log.info("contentString--------->" + contentString)
    ext = 'mind';
} else if ('txt'.equals(file.type) || 'code'.equals(file.type)) {
    // 处理文本和代码类型文件
    contentString = content.content;
} else {
    exit 400, '参数错误';
}

log.info("ext-->" + ext)
log.info("contentString-->" + contentString)
// 将内容保存到文件,并上传minio
fileName = FileUtil.createTempFile('.' + ext, true)
// fileName = "./"+now().format("yyyyMMddHHmmss")+"."+ext


log.info("fileName-->" + fileName)
var tempFile = FileUtil.writeUtf8String(contentString, fileName);
// log.info("tempFile-->" + tempFile)

// var data = FileUtil.readBytes(tempFile);
// // string filcontent = string(data)
log.info("FileUtil.readUtf8String(fileName)-->" + FileUtil.readUtf8String(fileName))

log.info("Content of temporary file---> " + FileUtil.readUtf8String(fileName));

InputStream inputStream = FileUtil.getInputStream(tempFile);
var newUrl = MinioUtil.uploadStream(inputStream, '.' + ext);
log.info("newUrl-->" + newUrl)
// 添加文件的url和文件后缀名
// content.put("url",newUrl);
// content.put("ext",ext);

log.info("contentObj::json ss" + contentObj::stringify)

// 重新计算文件大小
var fileSize = FileUtils.getFileSize(MinioUtil.preview(newUrl));

// 保存文件内容到file_contents
var fileContent = db.table('file_contents')
    .where()
    .eq('fid', id)
    .isNull('deleted_at')
    .selectOne();

var fileContentMap = {
    id: ObjectUtil.isNotEmpty(fileContent) ? fileContent.id : null,
    fid: id,
    content: content::stringify,
    text: text,
    size: fileSize,
    userid: userId,
    created_at: ObjectUtil.isNotEmpty(fileContent) ? fileContent.created_at : new Date(),
    updated_at: ObjectUtil.isNotEmpty(fileContent) ? fileContent.updated_at : null
}

db.table('file_contents')
    .primary('id', null)
    .save(fileContentMap);

// 保存文件到files
db.table('files').primary('id').update({
    id: id,
    size: fileSize,
    url: newUrl,
    ext: ext,
    updated_at: now()
});

//判断是否自动上传到知识库
//    /api/dataset/document/split
// 地址：http://127.0.0.1:8108/api/dataset/document/split
// 载荷 file
// todo 推送消息
return fileContentMap;