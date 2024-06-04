{
  "properties" : { },
  "id" : "cc20896df1c546fba56929cc75cb0309",
  "script" : null,
  "groupId" : "fd3d225a1cf141bf9998c4ec4bf4a6ab",
  "name" : "上传",
  "createTime" : 1646490239451,
  "updateTime" : 1643706737853,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/upload",
  "method" : "POST",
  "parameters" : [ ],
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
import org.ssssssss.magicboot.utils.FileUtils
import request;

var map = FileUtils.saveFile(request.getFile('file'));

db.table("sys_file").primary("id").saveOrUpdate({
    url: map.url,
    externalId: externalId,
    externalType: externalType
})

return map;