{
  "properties" : { },
  "id" : "b8dece243258482c948712201c860e08",
  "script" : null,
  "groupId" : "89c986b52b04478a95630c451428ab00",
  "name" : "设置或者关闭共享(同时遍历取消里面的共享)",
  "createTime" : 1716867163585,
  "updateTime" : 1711796466266,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/updataShare",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ {
    "name" : "file",
    "value" : null,
    "description" : "文件实体",
    "required" : false,
    "dataType" : "String",
    "type" : "java.util.Map",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ]
}
================================
  import log;
  // 如果没有共享用户，则设置共享状态为0；否则设置为1（共享）
  var share = db.table('file_users').where().eq('file_id', id).count() == 0 ? 0 : 1;
  // 检查当前文件的共享状态是否需要更新
  if (share != file.share) {
      // 更新当前文件的共享状态
      db.table('files').primary('id').update({
          id: id,
          share: share
      })
      // 如果文件被共享，设置pshare为当前文件ID，否则设置为0
      var pshareValue = share == 1 ? file.id : 0;
      log.info("file=",file);
      db.update("""
                update files 
                set share = 0,pshare = #{pshareValue} 
                where id_path LIKE CONCAT(#{file.id_path}, '%') and deleted_at is null and id <> #{file.id}
            """)

      // 如果文件的共享状态被设置为0（非共享），则删除所有相关的共享用户记录
      if (share == 0) {
          // 删除指定共享成员
          db.table('file_users')
              .where()
              .eq('file_id', file.id)
              .delete();
          // 同时删除成员分享的链接
          db.table('file_links')
              .where()
              .eq('file_id', file.id)
              .delete();
      }

  }
  return 'Hello magic-api'