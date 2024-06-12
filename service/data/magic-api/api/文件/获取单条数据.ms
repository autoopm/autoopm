{
  "properties" : { },
  "id" : "9c2811e7c0614e14b16a4e235ce7484b",
  "script" : null,
  "groupId" : "fbe74c5bc9f04c308679a525a09005a6",
  "name" : "获取单条数据",
  "createTime" : null,
  "updateTime" : 1718129090745,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/one",
  "method" : "GET",
  "parameters" : [ {
    "name" : "id",
    "value" : null,
    "description" : "Number 文件ID（需要登录） String 链接码（不需要登录，用于预览）",
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
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : null,
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