{
  "properties" : { },
  "id" : "bdd485b495a34d2ba67aafb2f39bb919",
  "script" : null,
  "groupId" : "fbe74c5bc9f04c308679a525a09005a6",
  "name" : "复制文件(夹)",
  "createTime" : null,
  "updateTime" : 1718176690778,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/copy",
  "method" : "GET",
  "parameters" : [ {
    "name" : "id",
    "value" : "123",
    "description" : "文件ID",
    "required" : true,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ {
    "name" : "token",
    "value" : "3ea3b487-f2b4-420d-bf9f-d5c111755b20",
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
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": null,\n    \"timestamp\": 1718163815909,\n    \"executeTime\": 146\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : {
    "name" : "",
    "value" : "",
    "description" : "",
    "required" : false,
    "dataType" : "Object",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "",
    "error" : "",
    "expression" : "",
    "children" : [ {
      "name" : "code",
      "value" : "200",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "message",
      "value" : "success",
      "description" : "",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "data",
      "value" : "null",
      "description" : "",
      "required" : false,
      "dataType" : "Object",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "timestamp",
      "value" : "1718155241990",
      "description" : "",
      "required" : false,
      "dataType" : "Long",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "executeTime",
      "value" : "59",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    } ]
  }
}
================================
import org.springframework.core.ReactiveAdapter
import org.junit.jupiter.params.provider.NullAndEmptySource
import cn.dev33.satoken.stp.StpUtil;
import com.alibaba.fastjson.JSONObject;
import org.ssssssss.magicboot.utils.MinioUtil;
import log;

var userId = StpUtil.getLoginId();
log.info("执行到这里-1")
// var userId = 6;
//根据文件id和userid去file_users表查询，是否有复制权限
var fileUsers = db.table("file_users").where().eq("file_id", id).eq("userid", userId).select();
log.info("执行到这里0：：：" + fileUsers)
if (fileUsers.size() == 0) {
    exit '没有找到可以复制的文件'
}
log.info("执行到这里0")
//重新保存一份
var nowAt = new Date();
var val = db.transaction(() => {
    log.info("执行到这里1")
    var fileCopy = db.table("files").where().eq("id", id).selectOne();
    //原始的对象
    var file_url = fileCopy.url;
    //对象名
    let fileName = file_url.substring(0, file_url.lastIndexOf('.'));
    //对象后缀
    let fileExtension = file_url.substring(file_url.lastIndexOf('.'));
    //新的对象要加copy
    // 构建新文件名，添加_copy并在末尾保留原始扩展名
    // let newObjectName = fileName + '_copy' + fileExtension;

    let counter = 1

    let tempObjectName = fileName + '_copy' + counter + fileExtension;
    log.info("tempObjectName is --->" + tempObjectName)

    log.info("执行到这里2")
    //检查是否存在，如果存在就再加
    while (MinioUtil.isObjectExists(tempObjectName)) {
        counter++;
        log.info("counter is --->" + counter)
        tempObjectName = fileName + '_copy' + counter + fileExtension;
        log.info("tempObjectName is --->" + tempObjectName)
    }


    //复制对象的名称
    MinioUtil.copyObject(fileCopy.url, tempObjectName);
    //检查文件是否存在
    var isExis = MinioUtil.isObjectExists(tempObjectName)

    if (isExis) {
        log.info("文件已拷贝成功");
    } else {
        log.info("文件不存在，可能拷贝异常了");
    }

    log.info("tempObjectName is --->" + tempObjectName)
    //存储files
    var data = {
        pid: fileCopy.pid,
        url: tempObjectName,
        name: fileCopy.name + '_copy' + counter,
        type: fileCopy.type,
        ext: fileCopy.ext,
        size: fileCopy.size,
        userid: userId,
        //TODO 还有share、cid
        pshare: fileCopy.pshare, //父目录的分享权限
        created_id: userId,
        created_at: nowAt,
        updated_at: nowAt,
        deleted_at: null,
    }
    var fileid = db.table("files").insert(data);
    log.info("执行到这里3")
    //
    var pids = '';

    log.info("pid value" + pid)
    var pid = fileCopy.pid //等于原来软件的pid

    if (pid == 0 || pid == '0') { //特殊处理了
        pids = "/" + fileid + "/";

    } else {
        // 获取父级的pids
        var idPath = db.table('files')
            .where()
            .eq("id", pid)
            .isNull('deleted_at')
            .selectOne();
        log.info("idPath value", idPath)
        pids = idPath.idPath + fileid + "/"
    }
    db.table('files').primary('id').update({
        id: fileid,
        pids: pids,
        id_path: pids
    })
    log.info("执行到这里4")

    //存储file_content 
    var content = {
        'from': '',
        'type': fileCopy.type,
        'ext': fileCopy.ext,
        'url': newObjectName
    }
    // 新增fileContent
    var fileContentMap = {
        fid: fileid,
        content: JSONObject.toJSONString(content),
        text: null, //TODO 这里应该都是null
        size: fileCopy.fileSize,
        userid: userId,
        created_at: nowAt,
        updated_at: nowAt
    }

    log.info("执行到这里5")
    var result = db.table('file_contents')
        .primary('id', null)
        .save(fileContentMap);
    return result;
});