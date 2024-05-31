{
  "properties" : { },
  "id" : "ae703ad1ce374d38b44fe5d7826ed46b",
  "script" : null,
  "groupId" : "89c986b52b04478a95630c451428ab00",
  "name" : "根据自身权限获取列表",
  "createTime" : 1717060654050,
  "updateTime" : 1717056184162,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/getFileListByPermission",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ {
    "name" : "name",
    "value" : null,
    "description" : "文件名称,关键词",
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.Object",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "fileId",
    "value" : null,
    "description" : "文件id",
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.Number",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "userId",
    "value" : null,
    "description" : "用户id",
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.Number",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "pid",
    "value" : null,
    "description" : "父id",
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.Number",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ]
}
================================
import org.ssssssss.magicboot.utils.MinioUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import 'cn.dev33.satoken.stp.StpUtil';
import log;

import env

var serviceUrl = env.get("public.domain") + ":" + env.get("server.port")
log.info("serviceUrl-->" + serviceUrl);


var fileList = db.select("""
SELECT
    f.id,
    f.pid,
    f.id_path,
    f.cid,
    f.name,
    f.type,
    f.ext,
    f.size,
    f.userid,
    f.pshare,
    f.share,
    f.created_id,
    f.created_at,
    f.url,
    f.updated_at,
    f.deleted_at,
    CASE
        WHEN f.userid =  #{userId} OR f.created_id =  #{userId} THEN 1000
        WHEN pu.max_permission IS NOT NULL THEN pu.max_permission
        ELSE COALESCE((SELECT MAX(fu.permission) FROM file_users fu WHERE fu.file_id = f.pshare), 0)
    END AS permission
FROM
    files f
LEFT JOIN (
    SELECT file_id, MAX(permission) AS max_permission
    FROM file_users
    GROUP BY file_id
) pu ON f.id = pu.file_id
WHERE
    f.deleted_at IS NULL
    <if test="fileId != null">
		AND f.id = #{fileId}
	</if>
	<if test="pid != null">
		AND f.pid = #{pid}
	</if>
    <if test="key != null and key != ''">
        AND f.name like concat('%',#{key},'%')
    </if>
    AND (
        f.userid =  #{userId}
        OR f.created_id =  #{userId}
        OR EXISTS (
            SELECT 1 FROM file_users fu1 WHERE fu1.userid IN ( #{userId}, -1) AND fu1.file_id IN (SELECT f1.id FROM files f1 WHERE f1.id_path LIKE CONCAT(f.id_path, '%'))
        )
        OR (
            f.pshare <> 0  AND EXISTS (SELECT 1 FROM file_users WHERE file_id = f.pshare AND (userid =  #{userId} OR userid = -1))
        )
    )
ORDER BY
    f.created_at DESC;
    """)
log.info("fileList-->" + fileList)

// 如果是图片，需要补充一下image_url,拼接域名部分：image_url = 域名部分+数据存的
// 数据库存的是：/uploads/file/picture/202403/36000/d24665e11caac178d1ac6de6ab1c8564.png
// 拼接域名部分："https://autoopm.com"，不固定，通过配置文件读取
for (file in fileList) {
    // 处理时间
    file.created_at = date_format(file.created_at);
    file.updated_at = date_format(file.updated_at);
    file.deleted_at = date_format(file.deleted_at);
    // 是图片才需要拼接
    if (StrUtil.isNotEmpty(file.url) && StrUtil.isNotEmpty(file.type) && "picture".equals(file.type)) {
        file.put("image_url", serviceUrl + '/api/file/preview/' + file.id);
    }

}

return fileList;