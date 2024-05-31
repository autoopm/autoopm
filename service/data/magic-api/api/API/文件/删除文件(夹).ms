{
  "properties" : { },
  "id" : "835b892be2dc4949a70b5bcd0e54666c",
  "script" : null,
  "groupId" : "7cc0839b044d4ab3a208aaf2142fbd7f",
  "name" : "删除文件(夹)",
  "createTime" : 1717060652971,
  "updateTime" : 1716776098912,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/remove",
  "method" : "GET",
  "parameters" : [ {
    "name" : "ids",
    "value" : "",
    "description" : "文件id,多个使用,分割",
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
  "responseBody" : "{\n    \"code\": 500,\n    \"message\": \"系统内部出现错误\",\n    \"data\": null,\n    \"timestamp\": 1711793828291,\n    \"executeTime\": 9627\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import 'cn.dev33.satoken.stp.StpUtil';

var userId = StpUtil.getLoginId()
var idList = StrUtil.split(ids, ',')

if (CollUtil.isEmpty(idList)) {
    exit 400, '请选择删除的文件或文件夹'
}

if (idList.size() > 100) {
    exit 400, '一次最多只能删除100个文件或文件夹'
}

var idSet = new HashSet(idList);
// 权限检测：只有所有者或者创建者才能删除
var num = db.table('files')
    .where()
    .in('id', idSet)
    .isNull('deleted_at')
    .and(it => it.eq('userid', userId).or().eq('created_id', userId))
    .count();

// 说明当前用户不是文件（夹）的所有者或创建这
if (idSet.size() != num) {
    exit 400, '仅限所有者或创建者操作';
}

// 如果是文件夹，递归删除，并删除权限信息和文件内容信息
const idPathList = db.table('files')
    .column('id_path')
    .where()
    .in('id', idSet)
    .isNull('deleted_at')
    .select();


if (CollUtil.isEmpty(idPathList)) {
    exit 400, '删除失败';
}

// 开启一个事物
var deletedAt = new Date();
var val = db.transaction(() => {
    // 删除文件内容
    var v1 = db.update("""
        UPDATE file_contents fc
        INNER JOIN (SELECT DISTINCT id FROM files WHERE deleted_at is null and
            <foreach collection="idPathList" item="item" separator=" OR " open="(" close=")">
                id_path LIKE CONCAT(#{item.get('id_path')}, '%')
            </foreach>
        ) sub ON fc.fid = sub.id
        SET fc.deleted_at = #{deletedAt}
        """)
    // 删除文件权限
    var v2 = db.update("""
        DELETE FROM file_users
        WHERE file_id IN (
            SELECT DISTINCT id FROM files
            WHERE deleted_at IS NULL 
            AND (
                <foreach collection="idPathList" item="idPath" separator=" OR " open="(" close=")">
                    id_path LIKE CONCAT(#{idPath.get('id_path')}, '%')
                </foreach>
            )
        )
    """)

    // 删除文件链接
    var v3 = db.update("""
        DELETE FROM file_links
        WHERE file_id IN (
            SELECT DISTINCT id FROM files
            WHERE deleted_at IS NULL 
            AND (
                <foreach collection="idPathList" item="idPath" separator=" OR " open="(" close=")">
                    id_path LIKE CONCAT(#{idPath.get('id_path')}, '%')
                </foreach>
            )
        )
    """)

    // 删除文件
    var v4 = db.update("""
        UPDATE files f
        INNER JOIN (SELECT DISTINCT id FROM files WHERE deleted_at is null and
            <foreach collection="idPathList" item="item" separator=" OR " open="(" close=")">
                id_path LIKE CONCAT(#{item.get('id_path')}, '%')
            </foreach>
        ) sub ON f.id = sub.id
        SET f.deleted_at = #{deletedAt}
        """)

    return v4;
});


return "删除成功"