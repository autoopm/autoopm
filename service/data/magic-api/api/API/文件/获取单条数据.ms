{
  "properties" : { },
  "id" : "42dcd423e3cc4a679714ec89595d9ec1",
  "script" : null,
  "groupId" : "7cc0839b044d4ab3a208aaf2142fbd7f",
  "name" : "获取单条数据",
  "createTime" : 1716867156986,
  "updateTime" : 1712148573052,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/one",
  "method" : "GET",
  "parameters" : [ {
    "name" : "id",
    "value" : "18",
    "description" : "Number 文件ID（需要登录） String 链接码（不需要登录，用于预览）",
    "required" : true,
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": [\n        {\n            \"id\": 18,\n            \"pid\": 17,\n            \"id_path\": \"/13/17/18\",\n            \"cid\": 0,\n            \"NAME\": \"文件1\",\n            \"type\": \"picture\",\n            \"ext\": \"png\",\n            \"size\": 0,\n            \"userid\": 0,\n            \"pshare\": 17,\n            \"SHARE\": 0,\n            \"created_id\": 0,\n            \"created_at\": null,\n            \"url\": null,\n            \"permission\": 1\n        }\n    ],\n    \"timestamp\": 1711935320433,\n    \"executeTime\": 8\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.util.NumberUtil;
import '@/file/permissionFind' as permissionFind;
import 'cn.dev33.satoken.stp.StpUtil';

if (NumberUtil.isNumber(id)) {
   var userId = StpUtil.getLoginId()
    // 根据文件ID查询（需要登录）
    return permissionFind(id, userId, 0);
} else if (StrUtil.isNotEmpty(id)) {
    // 根据链接码查询（不需要登录，用于预览）
    var fileId = db.selectValue("""
    select file_id from file_links where code = #{id}
    """);

    if (ObjectUtil.isEmpty(fileId)) {
        exit 400, '链接不存在';
    }

    var file = db.table('files')
        .where()
        .isNull(deleted_at)
        .eq('id', fileId)
        .selectOne();

    if (ObjectUtil.isEmpty(file)) {
        exit 400, '链接不存在';
    }

    // 默认给查看权限
    if (ObjectUtil.isNotEmpty(file)) {
        file.put('permission', 0)
    }

    return file;
}