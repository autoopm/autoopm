{
  "properties" : { },
  "id" : "189374073fb84270875dde4c0f4976bc",
  "script" : null,
  "groupId" : "a0d32feaa58a4d318032215149d5cf40",
  "name" : "图片上传-未完成",
  "createTime" : 1717060653694,
  "updateTime" : 1713325150720,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/imgupload",
  "method" : "POST",
  "parameters" : [ {
    "name" : "image",
    "value" : { },
    "description" : null,
    "required" : true,
    "dataType" : "MultipartFile",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"url\": \"http://127.0.0.1:9000/task/2024-04-01/9d940100928b44e88c93cea9e2279b6a.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20240401%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240401T074345Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=e52f53d38000d4d397eb5ae0a382000ac6750858f4c1ee04db889c5e93cdbc81\"\n    },\n    \"timestamp\": 1711957425208,\n    \"executeTime\": 128\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import request;
import log
import org.ssssssss.magicboot.utils.MinioUtil

var file = request.getFile('image');
log.info('---------file--')

if (file != null) {
    log.info('---------file have value--')
} else {
    log.info('---------file is null--')
}
//检查桶是否存在
// var check = MinioUtil.bucketExists('task')
var check = true;
log.info('check value  ' + check)
if (check) {
    // upload里面已经检查了，如果不存在桶，会自动创建一个名为task的桶
    var result = MinioUtil.upload(file)
    return {
        url: MinioUtil.preview(result)
    }
    return
}
return '服务器存储异常'

// {
//     "ret": 1,
//     "msg": "success",
//     "data": {
//         "name": "\u622a\u5c4f2024-02-27 20.29.41.png",
//         "size": 111.36,
//         "file": "\/var\/www\/public\/uploads\/user\/picture\/1\/202402\/ac89c6e77ecfeb11bac7e2bd85c7cb5d.png",
//         "path": "uploads\/user\/picture\/1\/202402\/ac89c6e77ecfeb11bac7e2bd85c7cb5d.png",
//         "url": "http:\/\/autoo.com\/uploads\/user\/picture\/1\/202402\/ac89c6e77ecfeb11bac7e2bd85c7cb5d.png",
//         "thumb": "http:\/\/autoo.com\/uploads\/user\/picture\/1\/202402\/ac89c6e77ecfeb11bac7e2bd85c7cb5d.png_thumb.png",
//         "width": 1300,
//         "height": 501,
//         "ext": "png"
//     }
// }