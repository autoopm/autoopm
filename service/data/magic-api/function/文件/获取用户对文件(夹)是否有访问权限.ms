{
  "properties" : { },
  "id" : "338a7d440b4946a9805a5cd45b60ae71",
  "script" : null,
  "groupId" : "89c986b52b04478a95630c451428ab00",
  "name" : "获取用户对文件(夹)是否有访问权限",
  "createTime" : 1717060654063,
  "updateTime" : 1711251238001,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/getPermission",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ {
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
  } ]
}
================================
var permission = db.selectValue("""
SELECT
CASE
		
	WHEN
		( f.userid = #{userId} OR f.created_id =  #{userId} ) THEN
			1000 ELSE COALESCE ( MAX( fu.permission ), 0 ) 
			END AS permission 
	FROM
		files f
		LEFT JOIN file_users fu ON f.id = fu.file_id 
		AND fu.userid IN (  #{userId}, - 1 ) 
	WHERE
		((
				f.userid =  #{userId} 
				OR f.created_id =  #{userId}
				) 
			OR EXISTS (
			SELECT
				1 
			FROM
				file_users fu1 
			WHERE
				fu1.userid IN (  #{userId}, - 1 ) 
				AND fu1.file_id IN ( SELECT f1.id FROM files f1 WHERE f1.id_path LIKE CONCAT( f.id_path, '%' ) ) 
			) 
		) 
		AND f.deleted_at IS NULL 
		AND f.id = #{fileId} 
	GROUP BY
		f.id 
""")


return permission;