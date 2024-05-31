{
  "properties" : { },
  "id" : "10fc52dac0b44738ab40cc3705f6c0c2",
  "script" : null,
  "groupId" : "731c0f0eb0fd4dd792004009271d66fa",
  "name" : "会员列表",
  "createTime" : 1717060653337,
  "updateTime" : 1713325114397,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/lists",
  "method" : "GET",
  "parameters" : [ {
    "name" : "keys[department]",
    "value" : "27",
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
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ {
    "name" : "token",
    "value" : "d625f2aa-4130-40d6-9e8a-7d89f44422a6",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"data\": [\n            {\n                \"userid\": 2,\n                \"identity\": \",\",\n                \"department\": [\n                    \"27\"\n                ],\n                \"az\": \"T\",\n                \"pinyin\": \"\",\n                \"email\": \"test@dootask.com\",\n                \"tel\": \"\",\n                \"nickname\": \"测试人员\",\n                \"profession\": \"测试员\",\n                \"userimg\": \"\",\n                \"encrypt\": \"18cZzh\",\n                \"password\": \"7eedd4cbf70da996d21f641bcc6cb412\",\n                \"changepass\": 0,\n                \"login_num\": 63,\n                \"last_ip\": \"127.0.0.1\",\n                \"last_at\": 1704952511000,\n                \"line_ip\": \"127.0.0.1\",\n                \"line_at\": 1704952511000,\n                \"task_dialog_id\": 16,\n                \"created_ip\": \"\",\n                \"disable_at\": null,\n                \"email_verity\": true,\n                \"bot\": 0,\n                \"created_at\": \"2024-01-11 07:58:45\",\n                \"updated_at\": 1704952531000,\n                \"nickname_original\": \"测试人员\"\n            }\n        ]\n    },\n    \"timestamp\": 1709028657874,\n    \"executeTime\": 4\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
//TODO 搜索部分未完成
import log
import request;

var dbBuilder = db.table("users").where().isNull("disable_at").eq("bot", 0).orderByDesc("userid")

//只能这样子处理了
// let department = request.getValues('keys[department]')
// log.info("keys11111111：" + par)
if (department != null && department != "") {
    dbBuilder.like("department", '%' + depa + '%')
}

var users = dbBuilder.select()

for (item in users) {
    log.info("item" + item)
    item.nickname_original = item.nickname
    if (item.department == "" || item.department == null) {
        log.info("item.department is null")
        item.department = []
        //显示部门id
    } else { //处理成数组
        log.info("item department" + item.department)
        item.department = item.department.split(',')
    }

    if (item.identity == "") {
        log.info("item.department is null")
        item.identity = []
        //显示部门id 
    }


    // if (item.identity = "") {
    //     item.identity = identity

    // }
}


// if (isset($keys['department'])) {
//                 if ($keys['department'] == '0') {
//                     $builder->where(function($query) {
//                         $query->where("department", "")->orWhere("department", ",,");
//                     });
//                 } else {
//                     // 关联user_departments表中owner_userid查询出负责人，重新排序，部门负责人始终在前面
//                     $builder->where(function($query) use ($keys) {
//                         $query->where("department", "like", "%,{$keys['department']},%");
//                         $query->orWhereIn('userid', function ($query) use ($keys) {
//                             $query->select('owner_userid')->from('user_departments')->where("id", "=", trim($keys['department'], ','));
//                         });
//                     });
//                     $prefix = \DB::getTablePrefix();
//                     $builder->selectRaw("if(EXISTS(select id from {$prefix}user_departments where owner_userid = userid and id={$keys['department']}),1,0) as is_principal");
//                     $builder->orderBy("is_principal","desc");
//                 }
//             }


var result = {}
result.data = users
return result