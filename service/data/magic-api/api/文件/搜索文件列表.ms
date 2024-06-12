{
  "properties" : { },
  "id" : "aaa4bb9856104c5487ab4f505f0c70f3",
  "script" : null,
  "groupId" : "fbe74c5bc9f04c308679a525a09005a6",
  "name" : "搜索文件列表",
  "createTime" : null,
  "updateTime" : 1718038943124,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/search",
  "method" : "GET",
  "parameters" : [ {
    "name" : "link",
    "value" : null,
    "description" : "通过分享地址搜索（如：https://aaaa.com/single/file/JBS2lmVQ==）",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "key",
    "value" : "知识",
    "description" : "关键词",
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
import cn.hutool.core.util.StrUtil
import cn.hutool.core.util.ObjectUtil
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.util.ReUtil;
import log;
import '@/file/getFileListByPermission' as getFileListByPermission;
// 通过分享地址搜索（如：https://t.hitosea.com/single/file/ODcwOCwzOSxpa0JBS2lmVQ==）
// 根据文件夹或者文件的名称来模糊匹配

//TODO 这里需要处理
// var userId = StpUtil.getLoginId()
var userId = '1';

// 从请求中获取文件链接和搜索关键词，并去除空白字符
var linkStr = StrUtil.trim(link);
var name = StrUtil.trim(key);

// 初始化文件ID和获取数量
var id = 0;
var take = 50;

// 通过分享地址搜索
var fileId = null;
if (StrUtil.isNotEmpty(linkStr)) {
    // https://t.hitosea.com/single/file/ODcwOCwzOSxpa0JBS2lmVQ==
    // 提取分享码:ODcwOCwzOSxpa0JBS2lmVQ==
    String regex = '/\/single\/file\/(.*?)$/i';
    var code = ReUtil.get(regex, linkStr, 1);
    var fileLink = db.table('file_links')
        .column('file_id')
        .where()
        .eq('code ', code)
        .selectOne();

    if (ObjectUtil.isEmpty(fileLink) || StrUtil.isEmpty(fileLink.get('file_id'))) {
        return 'success';
    }
    fileId = fileLink.get('file_id');
}

// 搜索自己有权限看到的
var fileList = getFileListByPermission(name, fileId, userId, null);
return fileList;