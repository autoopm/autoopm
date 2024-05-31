{
  "properties" : { },
  "id" : "7d313a7fa3344e948b85f46ca2efe4c8",
  "script" : null,
  "groupId" : "a0d32feaa58a4d318032215149d5cf40",
  "name" : "系统设置",
  "createTime" : 1717060653703,
  "updateTime" : 1713325152360,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/setting",
  "method" : "GET",
  "parameters" : [ ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": [],\n    \"timestamp\": 1710030455179,\n    \"executeTime\": 18\n}",
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
      "value" : "500",
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
      "value" : "系统内部出现错误",
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
      "value" : "1710030333535",
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
      "value" : "11",
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
import log

if (type == "save") { //TODO 保存未实现
    //判断当前是否是管理员
    //判断自动归档时长
    
} else {
    var system = db.table("settings").where().eq("name", "system").selectOne()
    log.info('system value ' + system)
    if (system != null) { //    全部走默认
        if (system.setting != null) {
            log.info('result value: ' + system.setting::json)
            var result = system.setting::json
            // if (result.task_default_time == null) {
            //     log.info('task_default_time' + task_default_time)
            //     var time = [
            //         '09:00', '18:00'
            //     ]
            //     result.task_default_time = time
            // } else {
            //     log.info('task_default_time no null')
            // }
            result.reg = result.reg || 'open';
            result.reg_identity = result.reg_identity || 'normal';
            result.login_code = result.login_code || 'auto';
            result.password_policy = result.password_policy || 'simple';
            result.chat_information = result.chat_information || 'open';
            result.anon_message = result.anon_message || 'open';
            result.auto_archived = result.auto_archived || 'close';
            result.archived_day = result.archived_day || 7;
            result.task_visible = result.task_visible || 'close';
            result.task_default_time = result.task_default_time || ['09:00', '18:00'];
            result.all_group_mute = result.all_group_mute || 'open';
            result.all_group_autoin = result.all_group_autoin || 'yes';
            result.image_compress = result.image_compress || 'open';
            result.image_save_local = result.image_save_local || 'open';
            result.start_home = result.start_home || 'close';
            result.file_upload_limit = result.file_upload_limit || '';
            result.unclaimed_task_reminder = result.unclaimed_task_reminder || 'close';
            result.unclaimed_task_reminder_time = result.unclaimed_task_reminder_time || '';
            return result
        }
        var result = {}
        result.reg =  'open';
        result.reg_identity = 'normal';
        result.login_code =  'auto';
        result.password_policy = 'simple';
        result.chat_information =  'open';
        result.anon_message = 'open';
        result.auto_archived = 'close';
        result.archived_day =  7;
        result.task_visible = 'close';
        result.task_default_time =  ['09:00', '18:00'];
        result.all_group_mute =  'open';
        result.all_group_autoin =  'yes';
        result.image_compress =  'open';
        result.image_save_local =  'open';
        result.start_home =   'close';
        result.file_upload_limit =  '';
        result.unclaimed_task_reminder =  'close';
        result.unclaimed_task_reminder_time =  '';

        return result
    }
    return []
}