{
  "properties" : { },
  "id" : "874aea2c17ca4c79bcdff3d4cc458c87",
  "script" : null,
  "groupId" : "fd3d225a1cf141bf9998c4ec4bf4a6ab",
  "name" : "裁剪",
  "createTime" : 1646490239458,
  "updateTime" : 1643706719537,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/cropper",
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
import org.ssssssss.magicboot.model.Global
import org.ssssssss.magicboot.utils.FileUtils
import cn.hutool.core.io.FileUtil;
import java.net.URLDecoder
import request;

url = URLDecoder.decode(url, "UTF-8");
String realPath = Global.getUserFilesBaseDir() + "/" + url;
FileUtil.del(realPath);

var map = FileUtils.saveFile(request.getFile('file'));

db.table("sys_file").column("url", map.url).where().eq("url", url).update()

return map