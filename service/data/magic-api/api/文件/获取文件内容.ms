{
  "properties" : { },
  "id" : "968f551af77d479e954dae143cca5469",
  "script" : null,
  "groupId" : "fbe74c5bc9f04c308679a525a09005a6",
  "name" : "获取文件内容",
  "createTime" : null,
  "updateTime" : 1718276050200,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/content",
  "method" : "GET",
  "parameters" : [ {
    "name" : "id",
    "value" : "143",
    "description" : "Number: 文件ID（需要登录） String: 链接码（不需要登录，用于预览）",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "only_update_at",
    "value" : null,
    "description" : "仅获取update_at字段  no (默认) yes",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "no",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "down",
    "value" : null,
    "description" : "直接下载  no: 浏览（默认） yes: 下载（office文件直接下载，除非是preview） preview: 转预览地址",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "no",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "history_id",
    "value" : null,
    "description" : "读取历史记录ID",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "no",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "token",
    "value" : "9404a2a8-1b45-4a39-b242-45d30a234d6c",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
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
import org.ssssssss.magicboot.utils.MinioUtil
import com.google.gson.JsonObject
import cn.hutool.core.util.NumberUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import response;
import java.net.URLEncoder;
import '@/file/permissionFind' as permissionFind;
import cn.dev33.satoken.stp.StpUtil;
import log;

var file = null;
log.info("到达这里了1.......");
if (NumberUtil.isNumber(id)) {
    //根据token获取是哪个用户
    log.info("到达这里了2.......");
    // var userId = StpUtil.getLoginId();
    // var userId = 6; //测试时候打开
    // 根据文件ID查询（需要登录）
    var userId = StpUtil.getLoginIdByToken(token)
    log.info("userId......." + userId);
    file = permissionFind(userId, id, "yes".equals(down) ? 1 : 0);
} else if (StrUtil.isNotEmpty(id)) {
    // 如果参数不为空，根据链接码查找文件id
    var fileId = db.selectValue("""
    select file_id from file_links where code = #{id}
    """);
    if (StrUtil.isEmpty(fileId)) {
        exit 400, '文件链接不存在';
    }
    // 根据文件id查出文件
    file = db.table('files')
        .where()
        .isNull('deleted_at')
        .eq('id', fileId)
        .selectOne();

    if (ObjectUtil.isEmpty(file)) {
        exit 400, '文件链接不存在';
    }

    // 默认给查看权限
    if (ObjectUtil.isNotEmpty(file)) {
        file.put('permission', 0)
    }

} else {
    exit 400, '参数错误';
}


// 如果请求仅为更新时间，则返回文件更新时间和文件id
if ("yes".equals(only_update_at)) {
    var result = {
        "id": file.id,
        "update_at": file.updated_at
    };
    return result;
}

// 否则，获取文件内容
var fileContent = db.table('file_contents')
    .where()
    .isNull('deleted_at')
    .eq('fid', file.id)
    .orderByDesc('id')
    .selectOne();
log.info("fileContent-->" + fileContent)

// 设置文件名，如果存在文件扩展名，则将扩展名添加到文件名中
String fileName = StrUtil.isNotEmpty(file.ext) ? (file.name + '.' + file.ext) : "";
// 确保文件名正确地包含扩展名
if (StrUtil.isNotEmpty(fileName) && !fileName.contains('.')) {
    fileName += '.';
}

// 检查文件类型是否为word、excel或ppt
var fileTypeArray = ['word', 'excel', 'ppt'];
var fileTypeMap = {
    'word': 'docx',
    'excel': 'xlsx',
    'ppt': 'pptx'
};
const codeExt = [
    'txt',
    'htaccess', 'htgroups', 'htpasswd', 'conf', 'bat', 'cmd', 'cpp', 'c', 'cc', 'cxx', 'h', 'hh', 'hpp', 'ino', 'cs', 'css',
    'dockerfile', 'go', 'golang', 'html', 'htm', 'xhtml', 'vue', 'we', 'wpy', 'java', 'js', 'jsm', 'jsx', 'json', 'jsp', 'less', 'lua', 'makefile', 'gnumakefile',
    'ocamlmakefile', 'make', 'mysql', 'nginx', 'ini', 'cfg', 'prefs', 'm', 'mm', 'pl', 'pm', 'p6', 'pl6', 'pm6', 'pgsql', 'php',
    'inc', 'phtml', 'shtml', 'php3', 'php4', 'php5', 'phps', 'phpt', 'aw', 'ctp', 'module', 'ps1', 'py', 'r', 'rb', 'ru', 'gemspec', 'rake', 'guardfile', 'rakefile',
    'gemfile', 'rs', 'sass', 'scss', 'sh', 'bash', 'bashrc', 'sql', 'sqlserver', 'swift', 'ts', 'typescript', 'str', 'vbs', 'vb', 'v', 'vh', 'sv', 'svh', 'xml',
    'rdf', 'rss', 'wsdl', 'xslt', 'atom', 'mathml', 'mml', 'xul', 'xbl', 'xaml', 'yaml', 'yml',
    'asp', 'properties', 'gitignore', 'log', 'bas', 'prg', 'python', 'ftl', 'aspx', 'plist'
];

const officeExt = [
    'doc', 'docx',
    'xls', 'xlsx',
    'ppt', 'pptx',
];

// 将文件内容解析为json对象,这里是fileContent的content字段
var contentJsonObject = ObjectUtil.isNotEmpty(fileContent) && StrUtil.isNotEmpty(fileContent.content) ? fileContent.content::json : null;

// if (fileContent!=null){
//     contentJsonObject = fileContent.content    
// }

// 转到预览地址
if ('preview'.equals(down)) {
    var filePath = fileContent.url;
    // 针对word，excel，ppt的处理
    if (fileTypeArray.contains(file.type)) {
        if (ObjectUtil.isEmpty(contentJsonObject) || StrUtil.isEmpty(contentJsonObject)) {
            log.info("preview-contentJsonObject--->", contentJsonObject);
            filePath = 'empty.' + fileTypeMap.get(file.type);
        }
        // todo 这里还需要做预览处理
    }
}

// 针对word，excel，ppt的处理
if (fileTypeArray.contains(file.type)) {
    // 如果文件内容为空，则返回包含空白文件的下载响应
    if (ObjectUtil.isEmpty(contentJsonObject)) {
        log.info("contentJsonObject--->", contentJsonObject);
        return response.download(null, 'empty.' + fileTypeMap.get(file.type));
    }
    // 否则，返回包含文件内容的下载响应
    return response.download(MinioUtil.download(file.url), fileName);
}

// 如果文件内容为空
if (ObjectUtil.isEmpty(contentJsonObject)) {
    contentJsonObject = {};
    // 根据文件类型为document，则设置默认内容
    if ("document".equals(file.type)) {
        contentJsonObject = {
            type: file.ext,
            content: ""
        }
    }

    // 可能网络异常，没存成功，不给下载
    if ("yes".equals(down)) {
        exit 403, 'This file is empty.';
    }

} else {
    // 如果文件存在扩展名
    if (StrUtil.isNotEmpty(file.ext)) {
        // 设置文件内容,格式化内容数据
        if ("md".equals(file.ext) || "text".equals(file.ext)) {
            // 文本
            contentJsonObject = {
                'type': file.ext,
                'content': ObjectUtil.isNotEmpty(contentJsonObject) && StrUtil.isNotEmpty(contentJsonObject.get('content')) ? contentJsonObject.get('content') : 'Content deleted'
            }
        } else if ("drawio".equals(file.ext)) { // 图表
            contentJsonObject = contentJsonObject;
        } else if ("mind".equals(file.ext)) { // 思维导图
            contentJsonObject = ObjectUtil.isNotEmpty(contentJsonObject) ? contentJsonObject : {};
        } else {
            // 其他预览
            // 检查文件扩展名是否在允许的代码文件扩展名数组中，并且文件大小小于2MB
            if (codeExt.contains(file.ext) && file.size << 2 * 1024 * 1024) {
                contentJsonObject = {
                    'content': ObjectUtil.isNotEmpty(contentJsonObject) && StrUtil.isNotEmpty(contentJsonObject.get('content')) ? contentJsonObject : 'Content deleted'
                }
            } else if (officeExt.contains(file.ext)) {
                // office预览
                contentJsonObject = {
                    'content': {}
                }
            } else {
                // 其他预览
                contentJsonObject = {
                    'preview': true,
                    'name': fileName,
                    'key': file.id
                }
                // todo file_mode?  $data['file_mode'] = 'preview';
            }
        }


    } else {
        // 如果文件没有扩展名，则设置预览标志为false
        content['preview'] = false;
    }

    // 如果请求下载文件
    if ("yes".equals(down)) {
        // 如果文件路径存在
        if (StrUtil.isNotEmpty(file.url)) {
            log.info("file.url={}", file.url);
            // 返回文件下载响应
            return response.download(MinioUtil.download(file.url), fileName);
        } else {
            // 否则，返回403错误
            exit 403, 'This file not support download.';
        }
    }
}

var result = {
    content: contentJsonObject
}
return result;