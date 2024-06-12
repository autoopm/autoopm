{
  "properties" : { },
  "id" : "b185b1f67d9840149dee60d17cfa2fcd",
  "script" : null,
  "groupId" : "89c986b52b04478a95630c451428ab00",
  "name" : "上传知识库",
  "createTime" : 1717813170668,
  "updateTime" : 1716809386760,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/uploadkb",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ {
    "name" : "fileUrl",
    "value" : null,
    "description" : "文件url",
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.String",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ]
}
================================
import log
import http
import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import org.ssssssss.magicboot.utils.MinioUtil
import cn.hutool.core.io.FileUtil;
import cn.hutool.http.HttpUtil;
import cn.hutool.core.io.IoUtil;

var know = db.table("settings").where().eq("name", "know").selectOne();
if (know === null) {
    log.info("知识库未配置")
    return "知识库未配置"
} else {
    if (know != null && know.setting) {
        var result = know.setting::json
        if (result.auto_upload != "open") {
            return "自动上传未开启"
        }
        var apiUrl = result.linkUrl
        var user = result.user
        var pwd = result.pwd
        var dataSetId = result.appid

         log.info("result-->" + result)
         log.info("user-->" + user)
         log.info("pwd-->" + pwd)
        if (apiUrl != null && user != null && pwd != null && dataSetId != null) {
            //执行登录
            var responseEntity = http.connect(apiUrl + '/api/user/login').contentType('application/json').body({
                username: user,
                password: pwd,
            }).post().getBody();
            log.info("获取登录返回：" + responseEntity)
            if (responseEntity.code == 200) {
                log.info("登录成功")
                var token = responseEntity.data;
                log.info("token-->" + token)
                var firstIndex = fileUrl.indexOf(".")
                var prefix = fileUrl.substring(0, firstIndex)
                var suffix = fileUrl.substring(firstIndex, fileUrl.length())
                log.info("prefix-->" + prefix)
                log.info("suffix-->" + suffix)

                File tempFile = FileUtil.createTempFile(prefix, suffix, FileUtil.getTmpDir());
                FileUtil.writeBytes(MinioUtil.download(fileUrl), tempFile);
                log.info("临时文件已创建: " + tempFile.getAbsolutePath());
                var url = apiUrl + "/api/dataset/document/split";
                HttpRequest request = HttpRequest.post(url);
                request.form("file", tempFile);
                request.header("Authorization", token);
                HttpResponse execute = request.execute();
                boolean ok = execute.isOk();
                String body = execute.body();
                log.info("request execute.body-->" + body)
                var result = body::json.data
                String name = result[0].name;
                var content = result[0].content;
                log.info("request execute.body content-->" + content)
                //TODO 单文件自动上传只是取[0]是否正确
                //正式导入
                //处理数据
                var bodyData = [];
                var par = {};
                par.name = name;
                par.paragraphs = content
                bodyData.push(par)
                var responseEntity = http.connect(apiUrl + "/api/dataset/" + dataSetId + "/document/_bach").header("Authorization", token).contentType('application/json').body(bodyData).post().getBody();
                log.info("获取bach返回：" + responseEntity)
            }

        }
    }
}