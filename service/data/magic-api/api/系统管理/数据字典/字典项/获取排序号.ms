{
  "properties" : { },
  "id" : "5d5fc243a5594f79b95ed279e184732e",
  "script" : null,
  "groupId" : "376f26eb43a44a3daeafd27020a96f48",
  "name" : "获取排序号",
  "createTime" : 1646490239449,
  "updateTime" : 1634735599490,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/sort",
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
return db.selectInt("""select max(sort) + 10 from sys_dict_items where dict_id = #{dictId} and is_del = '0'""") || 10;