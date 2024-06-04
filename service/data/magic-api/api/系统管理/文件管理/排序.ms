{
  "properties" : { },
  "id" : "1d736fb0b9b54566943a0ea6696492c6",
  "script" : null,
  "groupId" : "fd3d225a1cf141bf9998c4ec4bf4a6ab",
  "name" : "排序",
  "createTime" : 1646490239454,
  "updateTime" : 1643706726137,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/resort",
  "method" : "GET",
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
import java.net.URLDecoder

for(index,url in urls.split(',')){
    url = URLDecoder.decode(url, "UTF-8")
    var id = db.selectValue("select id from sys_file where url = #{url}")
    db.table("sys_file").column("sort",index + 1).where().eq("id",id).update()
}