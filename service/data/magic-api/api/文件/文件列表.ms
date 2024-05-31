{
  "properties" : { },
  "id" : "333019c5837f4026ae772985341aafeb",
  "script" : null,
  "groupId" : "22e24c6facd143a49cf7e7cf201c727d",
  "name" : "文件列表",
  "createTime" : 1717060653952,
  "updateTime" : 1713257192464,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/lists",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ ],
  "requestBody" : "{\n    \"pid\":13\n}",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 500,\n    \"message\": \"系统内部出现错误\",\n    \"data\": null,\n    \"timestamp\": 1710505183537,\n    \"executeTime\": 5\n}",
  "description" : null,
  "requestBodyDefinition" : {
    "name" : "root",
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
      "name" : "pid",
      "value" : "12",
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
  },
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
      "value" : "文件存在",
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
      "name" : "timestamp",
      "value" : "1702457283482",
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
      "value" : "119",
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
import org.junit.jupiter.params.provider.NullAndEmptySource
import 'cn.dev33.satoken.stp.StpUtil';
import log;
var userId = StpUtil.getLoginId()
// var userId = '1'

// 设置权限值，如果用户是文件的创建者或拥有者，则权限值为1000。
var permission = 1000
var etype = "all"

// 如果类型为 'dir'，则只查询文件夹。
if (type = "dir") {
    etype = "folder"
}

if (body.pid > 0) {
    // todo 如果$pid大于0，说明不是根目录，需要检查权限
} else {
    // 如果是根目录，只查询当前用户的文件
    $builder -> whereUserid($user -> userid);
}

var fileList

// 需要查询该节点的所有子节点
if (body.pid > 0) {
    // 查询所有子节点
    var file = db.select("""
          SELECT * FROM files WHERE pid = #{body.pid} 
     """)
    log.info('file:' + file);
    if (file.getLength() == 0) { //判断文件是否存在
        return "文件不存在或已被删除"
    }
    //判断权限
    var limit = 0
    if (file[0].userid == userId || file[0].createdId == userId) {
        permission = 1000
    } else {
        //查找共享
        if (file[0].share) {
            log.info('共享文件夹-真，就返回这个文件或者目录');
            fileList = file[0] //TODO 这里需要处理
        }
        pid = file[0].pid
        //遍历获取最顶级的 pid
        while (pid > 0) {
            var fileTemp = db.select("""
               SELECT * FROM files WHERE id = #{pid} 
          """)
            if (fileTemp.getLength() == 0) { //判断文件是否存在
                break
            }
            if (fileTemp[0].share) {
                log.info('do this file:' + fileTemp[0]);
                //    return fileTemp[0]
                fileList = file[0] //TODO 这里需要处理
            }
            pid = fileTemp[0].pid
        }

        //查找文件共享表
        if (fileTemp.getLength() > 0) {
            var fileUser = db.selectOne("""
                              SELECT * FROM file_users WHERE id = #{pid} and #{userId} in userid   order by desc      permission """)
            if (fileUser.getLength() == 0) { //判断是否在指定共享成员内
                permission = fileUser.permission
                log.info('else permission:' + permission);
            }
        }

    }


} else {
    //获取用户自己的文件
    var file = db.table("files").where().eq("userid", userId).isNull('deleted_at').select()
    return file
}