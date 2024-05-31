{
  "properties" : { },
  "id" : "a49ed7f46073479cbf64fe8cba420d98",
  "script" : null,
  "groupId" : "f2a82a98ff1d49a3904430542a3d776d",
  "name" : "列表",
  "createTime" : 1717060653795,
  "updateTime" : 1716869174088,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/lists",
  "method" : "GET",
  "parameters" : [ {
    "name" : "keys",
    "value" : "",
    "description" : "搜索条件  keys.name: ID、任务名称",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "project_id",
    "value" : "",
    "description" : "项目ID",
    "required" : false,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : "0",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "parent_id",
    "value" : null,
    "description" : "主任务ID",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "timerange",
    "value" : null,
    "description" : "时间范围（如：1678248944,1678248944）  第一个时间: 读取在这个时间之后更新的数据 第二个时间: 读取在这个时间之后删除的数据ID（第1页附加返回数据: deleted_id）",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "archived",
    "value" : null,
    "description" : "归档状态  all：所有（parent_id > 0 时强制 all） yes：已归档 no：未归档（默认）",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "no",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "deleted",
    "value" : null,
    "description" : "是否读取已删除  all：所有 yes：已删除 no：未删除（默认）",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "no",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "sorts",
    "value" : null,
    "description" : "排序方式  sorts.complete_at 完成时间：asc|desc sorts.archived_at 归档时间：asc|desc sorts.end_at 到期时间：asc|desc",
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
    "value" : "ba3b1eb0-ecd8-4baa-8424-0efb7612b3e0",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"data\": [\n            {\n                \"id\": 127,\n                \"parent_id\": 0,\n                \"project_id\": 93,\n                \"column_id\": 127,\n                \"dialog_id\": \"52ffec73044645c580c3e5fa927c21bc\",\n                \"flow_item_id\": 283,\n                \"flow_item_name\": \"test|待测试\",\n                \"name\": \"仪表盘数据不正确\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712462086000,\n                \"end_at\": 1712548486000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 147,\n                        \"project_id\": 93,\n                        \"task_id\": 127,\n                        \"task_pid\": 127,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712462101000,\n                        \"updated_at\": null\n                    },\n                    {\n                        \"id\": 162,\n                        \"project_id\": 93,\n                        \"task_id\": 127,\n                        \"task_pid\": 127,\n                        \"userid\": 0,\n                        \"owner\": 1,\n                        \"created_at\": 1712621461000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 128,\n                \"parent_id\": 0,\n                \"project_id\": 93,\n                \"column_id\": 127,\n                \"dialog_id\": \"d16423fa1deb4ead912e8ad0e172142b\",\n                \"flow_item_id\": 283,\n                \"flow_item_name\": \"test|待测试\",\n                \"name\": \"重新进入系统偶尔出现不正常\",\n                \"color\": \"\",\n                \"desc\": \"http://localhost:3000/manage/dashboard\",\n                \"start_at\": 1712462100000,\n                \"end_at\": 1712548500000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 148,\n                        \"project_id\": 93,\n                        \"task_id\": 128,\n                        \"task_pid\": 128,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712462143000,\n                        \"updated_at\": null\n                    },\n                    {\n                        \"id\": 161,\n                        \"project_id\": 93,\n                        \"task_id\": 128,\n                        \"task_pid\": 128,\n                        \"userid\": 0,\n                        \"owner\": 1,\n                        \"created_at\": 1712597757000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 129,\n                \"parent_id\": 0,\n                \"project_id\": 93,\n                \"column_id\": 127,\n                \"dialog_id\": \"131d7dd57bfb4d2d85aba94bb6e432cc\",\n                \"flow_item_id\": 281,\n                \"flow_item_name\": \"start|待处理\",\n                \"name\": \"获取任务的聊天条数显示到任务卡片上\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712462100000,\n                \"end_at\": 1712548500000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 149,\n                        \"project_id\": 93,\n                        \"task_id\": 129,\n                        \"task_pid\": 129,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712462179000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 130,\n                \"parent_id\": 0,\n                \"project_id\": 93,\n                \"column_id\": 127,\n                \"dialog_id\": \"0e1cef51ed4749b9a322eb121df68e23\",\n                \"flow_item_id\": 281,\n                \"flow_item_name\": \"start|待处理\",\n                \"name\": \"新建任务弹窗回车键响应\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712462148000,\n                \"end_at\": 1712548548000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 150,\n                        \"project_id\": 93,\n                        \"task_id\": 130,\n                        \"task_pid\": 130,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712462220000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 131,\n                \"parent_id\": 0,\n                \"project_id\": 93,\n                \"column_id\": 127,\n                \"dialog_id\": \"8b88c1481e524b5ea92c3e3896e8990c\",\n                \"flow_item_id\": 281,\n                \"flow_item_name\": \"start|待处理\",\n                \"name\": \"新建任务的时候，是swtich按钮替换下拉选择\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712462233000,\n                \"end_at\": 1712548633000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 151,\n                        \"project_id\": 93,\n                        \"task_id\": 131,\n                        \"task_pid\": 131,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712462266000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 132,\n                \"parent_id\": 0,\n                \"project_id\": 93,\n                \"column_id\": 127,\n                \"dialog_id\": \"715d431d147e40f9a2abd14f94931544\",\n                \"flow_item_id\": 284,\n                \"flow_item_name\": \"end|已完成\",\n                \"name\": \"推送一版前端代码到gitee仓库\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712462272000,\n                \"end_at\": 1712548672000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": 1712469652000,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 152,\n                        \"project_id\": 93,\n                        \"task_id\": 132,\n                        \"task_pid\": 132,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712462288000,\n                        \"updated_at\": null\n                    },\n                    {\n                        \"id\": 155,\n                        \"project_id\": 93,\n                        \"task_id\": 132,\n                        \"task_pid\": 132,\n                        \"userid\": 0,\n                        \"owner\": 1,\n                        \"created_at\": 1712469652000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 133,\n                \"parent_id\": 0,\n                \"project_id\": 93,\n                \"column_id\": 130,\n                \"dialog_id\": \"b468e20948304c6a80a9038dc14d6e0c\",\n                \"flow_item_id\": 281,\n                \"flow_item_name\": \"start|待处理\",\n                \"name\": \"新注册一个github账号\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712462335000,\n                \"end_at\": 1712548735000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 153,\n                        \"project_id\": 93,\n                        \"task_id\": 133,\n                        \"task_pid\": 133,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712462348000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 134,\n                \"parent_id\": 0,\n                \"project_id\": 93,\n                \"column_id\": 130,\n                \"dialog_id\": \"3849289adf0844c09aa09b04ad60be95\",\n                \"flow_item_id\": 281,\n                \"flow_item_name\": \"start|待处理\",\n                \"name\": \"发布项目到github\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712462357000,\n                \"end_at\": 1712548757000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 154,\n                        \"project_id\": 93,\n                        \"task_id\": 134,\n                        \"task_pid\": 134,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712462372000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 136,\n                \"parent_id\": 0,\n                \"project_id\": 95,\n                \"column_id\": 135,\n                \"dialog_id\": \"dad90e0eb29d42fa9b157ae16eeeef73\",\n                \"flow_item_id\": 291,\n                \"flow_item_name\": \"start|待处理\",\n                \"name\": \"12312\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712574415000,\n                \"end_at\": 1712660815000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 157,\n                        \"project_id\": 95,\n                        \"task_id\": 136,\n                        \"task_pid\": 136,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712574418000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 140,\n                \"parent_id\": 0,\n                \"project_id\": 93,\n                \"column_id\": 128,\n                \"dialog_id\": \"fb9415b4054d4939bb76041c09da51bf\",\n                \"flow_item_id\": 281,\n                \"flow_item_name\": \"start|待处理\",\n                \"name\": \"使用action发布安装包\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712621573000,\n                \"end_at\": 1712707973000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 163,\n                        \"project_id\": 93,\n                        \"task_id\": 140,\n                        \"task_pid\": 140,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712621586000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 141,\n                \"parent_id\": 0,\n                \"project_id\": 97,\n                \"column_id\": 139,\n                \"dialog_id\": \"e19954dbd86c4f4e915cb596b5e6fc97\",\n                \"flow_item_id\": 296,\n                \"flow_item_name\": \"start|待处理\",\n                \"name\": \"收藏夹整理\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712621607000,\n                \"end_at\": 1712708007000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 164,\n                        \"project_id\": 97,\n                        \"task_id\": 141,\n                        \"task_pid\": 141,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712621614000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 142,\n                \"parent_id\": 0,\n                \"project_id\": 93,\n                \"column_id\": 129,\n                \"dialog_id\": \"469ff25665e1462085232b4740a436c2\",\n                \"flow_item_id\": 281,\n                \"flow_item_name\": \"start|待处理\",\n                \"name\": \"标题修改报异常\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712621646000,\n                \"end_at\": 1712708046000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 165,\n                        \"project_id\": 93,\n                        \"task_id\": 142,\n                        \"task_pid\": 142,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712621674000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 143,\n                \"parent_id\": 0,\n                \"project_id\": 93,\n                \"column_id\": 129,\n                \"dialog_id\": \"1c550e3311ad44c391275b647b890653\",\n                \"flow_item_id\": 281,\n                \"flow_item_name\": \"start|待处理\",\n                \"name\": \"新建任务+图片异常\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712621728000,\n                \"end_at\": 1712708128000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 166,\n                        \"project_id\": 93,\n                        \"task_id\": 143,\n                        \"task_pid\": 143,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712621736000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 144,\n                \"parent_id\": 0,\n                \"project_id\": 93,\n                \"column_id\": 129,\n                \"dialog_id\": \"0cbf2280b9324b32958ab5c52d99ebc2\",\n                \"flow_item_id\": 284,\n                \"flow_item_name\": \"end|已完成\",\n                \"name\": \"删除列表报错\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712625970000,\n                \"end_at\": 1712712370000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": 1712626138000,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 167,\n                        \"project_id\": 93,\n                        \"task_id\": 144,\n                        \"task_pid\": 144,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712625979000,\n                        \"updated_at\": null\n                    },\n                    {\n                        \"id\": 168,\n                        \"project_id\": 93,\n                        \"task_id\": 144,\n                        \"task_pid\": 144,\n                        \"userid\": 0,\n                        \"owner\": 1,\n                        \"created_at\": 1712626138000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 145,\n                \"parent_id\": 0,\n                \"project_id\": 93,\n                \"column_id\": 130,\n                \"dialog_id\": \"dff73693558542fabd117055ccdd9d73\",\n                \"flow_item_id\": 281,\n                \"flow_item_name\": \"start|待处理\",\n                \"name\": \"autoopm 在gitee搜索不到\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712626241000,\n                \"end_at\": 1712712641000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 169,\n                        \"project_id\": 93,\n                        \"task_id\": 145,\n                        \"task_pid\": 145,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712626258000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 146,\n                \"parent_id\": 0,\n                \"project_id\": 97,\n                \"column_id\": 139,\n                \"dialog_id\": \"767bda589b474e1a95f93b2e63f98a4d\",\n                \"flow_item_id\": 296,\n                \"flow_item_name\": \"start|待处理\",\n                \"name\": \"备忘录整理\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712626266000,\n                \"end_at\": 1712712666000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 170,\n                        \"project_id\": 97,\n                        \"task_id\": 146,\n                        \"task_pid\": 146,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712626270000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 147,\n                \"parent_id\": 0,\n                \"project_id\": 97,\n                \"column_id\": 139,\n                \"dialog_id\": \"07f2214c603f4295a185cf6dcef91d4c\",\n                \"flow_item_id\": 296,\n                \"flow_item_name\": \"start|待处理\",\n                \"name\": \"百度云整理\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712626271000,\n                \"end_at\": 1712712671000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 171,\n                        \"project_id\": 97,\n                        \"task_id\": 147,\n                        \"task_pid\": 147,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712626277000,\n                        \"updated_at\": null\n                    }\n                ]\n            },\n            {\n                \"id\": 148,\n                \"parent_id\": 0,\n                \"project_id\": 97,\n                \"column_id\": 139,\n                \"dialog_id\": \"7936c790dae641b99d2605e9ea5cc5fc\",\n                \"flow_item_id\": 296,\n                \"flow_item_name\": \"start|待处理\",\n                \"name\": \"天翼云整理\",\n                \"color\": \"\",\n                \"desc\": \"\",\n                \"start_at\": 1712626278000,\n                \"end_at\": 1712712678000,\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"archived_follow\": 0,\n                \"complete_at\": null,\n                \"userid\": 22,\n                \"visibility\": 1,\n                \"p_level\": 1,\n                \"p_name\": \"重要且紧急\",\n                \"p_color\": \"#ED4014\",\n                \"sort\": 0,\n                \"loop\": \"\",\n                \"loop_at\": null,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"deleted_userid\": 0,\n                \"task_tag\": [],\n                \"msg_num\": 0,\n                \"task_user\": [\n                    {\n                        \"id\": 172,\n                        \"project_id\": 97,\n                        \"task_id\": 148,\n                        \"task_pid\": 148,\n                        \"userid\": 22,\n                        \"owner\": 1,\n                        \"created_at\": 1712626283000,\n                        \"updated_at\": null\n                    }\n                ]\n            }\n        ]\n    },\n    \"timestamp\": 1712635299683,\n    \"executeTime\": 51\n}",
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
      "value" : "400",
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
      "value" : "获取频道信息失败",
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
      "value" : "1712635212061",
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
      "value" : "9",
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
import 'cn.dev33.satoken.stp.StpUtil';
import log
import env
var wukongIMUrl = env.get("wukongim.endpoint")
log.info("wukongIMUrl" + wukongIMUrl);


var userid = StpUtil.getLoginId()

//project_id为 0 时查全部
if (project_id != 0) {
    //判断项目是否已归档，自己在不在项目中
    var useProject = db.table("projects").where().eq("id", project_id).notNull("archived_at").selectOne()
    if (useProject == null) {
        exit 400, '项目不存在或已归档'
    }
}

var builder = db.table("project_tasks").where().orderBy('sort').orderBy('id')

if (archived == 'yes') { //已归档
    builder.isNotNull("archived_at")
} else { //未归档
    builder.isNull("archived_at")
}

//project_id 不为 0 时这里需要判断一下
if (project_id != 0) {
    builder.eq("project_id", project_id)
} else {
    // 只查询自己有权限的项目
    var projects = db.select("""
        SELECT
            p.id
        FROM
            project_users pu 
        JOIN
            projects p  ON p.id = pu.project_id
        WHERE
            pu.userid = #{userid} 
        AND 
            p.deleted_at IS NULL
    """)

    if (projects.size() > 0) {
        let projectList = []
        for (item in projects) {
            log.info("projects-->", item)
            projectList.push(item.id)
        }
        log.info("projectList-->"+ projectList)
        builder.in("project_id",projectList)  
    }else{
        return []
    }

    //如果没有项目id，那就是首页，只查询和自己相关的任务

    // 只查询有自己的任务
    var tasks = db.select("""
        SELECT
            p.id
        FROM
            project_task_users pu 
        JOIN
            project_tasks p  ON p.id = pu.task_id
        WHERE
            pu.userid = #{userid} 
        AND 
            p.deleted_at IS NULL
    """)

    if (tasks.size() > 0) {
        let taskList = []
        for (item in tasks) {
            taskList.push(item.id)
        }
        log.info("task_id taskList-->"+ taskList)
        builder.in("id",taskList)  
    }else {
        return []
    }

}

if (keys == null) {
    log.info("关键词为空")
} else {
    // builder.like("name",keys)
}

if (timerange == null) {
    log.info("timerange为空")
} else {
    //时间范围
}

//TODO 删除的任务是否要看到

// 时间范围 timerange
//TODO 子任务先不考虑
//TODO 已归档不考虑

//TODO 分页暂时不考虑
var taskList = builder.select()
// task.sss = 111

var taskData = [];
import http;

for (item in taskList) {
    let users = []
    var taskUserbuilder = db.table("project_task_users").where().eq("task_id", item.id).orderBy('id')
    //项目id为0则查所有，实际不查也没问题
    if (project_id != 0) {
        taskUserbuilder.eq("project_id", project_id)
    }else{
        //如果没有项目id，那就是首页，只查询和自己相关的任务
    }
    taskUsers = taskUserbuilder.select()
    item.task_tag = [] //TODO tag先不管
    //获取频道数量
    var useridStr = userid::string
    // channelId = "1213" //频道id
     channelId = item.dialog_id //频道id

    var responseEntity = http.connect(wukongIMUrl+'/channel/messagesync').contentType('application/json').body({
        channel_id: channelId, // 频道的唯一ID，如果是群聊频道，建议使用群聊ID
        channel_type: 2, // 频道的类型 1.个人频道 2.群聊频道（个人与个人聊天不需要创建频道，系统将自动创建）
        start_message_seq: 0,
        end_message_seq: 10000,
        limit:100,
        pull_mode:1,
    }).post().getBody();

    log.info("获取频道信息列表responseEntity" + responseEntity)

    // if (responseEntity.status == 200) {
    //     log.info("获取频道信息成功")
    // } else {
    //     log.info("获取频道信息失败")
    //     exit 400, "获取频道信息失败";
    // }

    

    item.msg_num = responseEntity.messages.size() //数量
    //item.file_num = 99 //文件数量
    log.info("-----------")
    if (taskUsers != null) {
        if (taskUsers.size() > 0) {
            users.push(taskUsers)
            log.info("-----------taskUsers size >0")
            item.task_user = users
        } else {
            item.task_user = []
        }
        // item.task_user = []

    } else {
        log.info("-----------taskUsers size =0")
        item.task_user = []
    }

    // log.info("taskUsers is:::"+taskUsers)
    // log.info(taskUsers)
    // taskList.task_user = users
}
var data = {
    data
}
data.data = taskList

return data