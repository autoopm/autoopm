{
  "properties" : { },
  "id" : "e435b811dd074e89b5ae2c22d83b558c",
  "script" : null,
  "groupId" : "0c2d9f4051a44b37a9a0f361f4e13b75",
  "name" : "项目列表-ok",
  "createTime" : 1717060653762,
  "updateTime" : 1713325094258,
  "lock" : "1",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/lists",
  "method" : "GET",
  "parameters" : [ {
    "name" : "all",
    "value" : null,
    "description" : "是否查看所有项目（限制管理员）",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "type",
    "value" : null,
    "description" : "项目类型 all：全部（默认）team：团队项目 personal：个人项目",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "all",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "archived",
    "value" : null,
    "description" : "归档状态 all：全部 no：未归档（默认）yes：已归档",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "no",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "getcolumn",
    "value" : null,
    "description" : "同时取列表 no：不取（默认）yes：取列表",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "no",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "getuserid",
    "value" : null,
    "description" : "同时取成员ID no：不取（默认）yes：取列表",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "no",
    "validateType" : null,
    "error" : "",
    "expression" : "",
    "children" : null
  }, {
    "name" : "getstatistics",
    "value" : null,
    "description" : "同时取任务统计 no：不取 yes：取统计（默认）",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "yes",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "keys",
    "value" : null,
    "description" : "keys.name: 项目名称",
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
    "description" : "时间范围，时间戳格式",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "page",
    "value" : null,
    "description" : "当前页，默认:1",
    "required" : false,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : "1",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "pagesize",
    "value" : null,
    "description" : "每页显示数量，默认:50，最大:100",
    "required" : false,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : "50",
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ {
    "name" : "token",
    "value" : "52fbbf24-17c6-4825-96a3-8cd04a437dc1",
    "description" : null,
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"data\": [\n            {\n                \"id\": 89,\n                \"name\": \"23424\",\n                \"desc\": \"\",\n                \"userid\": 6,\n                \"personal\": false,\n                \"user_simple\": \"\",\n                \"dialog_id\": \"59e8e671d2144f61a69b6f7a3940011d\",\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"channel_id\": null,\n                \"owner\": 6,\n                \"userid_list\": [\n                    6,\n                    6\n                ]\n            },\n            {\n                \"id\": 91,\n                \"name\": \"测1\",\n                \"desc\": \"\",\n                \"userid\": 6,\n                \"personal\": false,\n                \"user_simple\": \"\",\n                \"dialog_id\": \"3a3b1b55a82d4a12bac6b4b6553fbd15\",\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"channel_id\": null,\n                \"owner\": 6,\n                \"userid_list\": [\n                    6\n                ]\n            },\n            {\n                \"id\": 92,\n                \"name\": \"12313\",\n                \"desc\": \"\",\n                \"userid\": 6,\n                \"personal\": false,\n                \"user_simple\": \"\",\n                \"dialog_id\": \"926af67729c743be922758c568f02375\",\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"channel_id\": null,\n                \"owner\": 6,\n                \"userid_list\": [\n                    6\n                ]\n            },\n            {\n                \"id\": 94,\n                \"name\": \"测试\",\n                \"desc\": \"\",\n                \"userid\": 6,\n                \"personal\": false,\n                \"user_simple\": \"\",\n                \"dialog_id\": \"b529e7fed1a7430fac86475dc95186de\",\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"channel_id\": null,\n                \"owner\": 6,\n                \"userid_list\": [\n                    6\n                ]\n            },\n            {\n                \"id\": 96,\n                \"name\": \"项目测试1\",\n                \"desc\": \"\",\n                \"userid\": 6,\n                \"personal\": false,\n                \"user_simple\": \"\",\n                \"dialog_id\": \"87ec61f3449c4b898591976a50613233\",\n                \"archived_at\": null,\n                \"archived_userid\": 0,\n                \"created_at\": null,\n                \"updated_at\": null,\n                \"deleted_at\": null,\n                \"channel_id\": null,\n                \"owner\": 6,\n                \"userid_list\": [\n                    6,\n                    6\n                ]\n            }\n        ],\n        \"total_all\": 5\n    },\n    \"timestamp\": 1712598094001,\n    \"executeTime\": 4\n}",
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
      "value" : "200",
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
      "value" : "success",
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
        "name" : "data",
        "value" : "",
        "description" : "",
        "required" : false,
        "dataType" : "Array",
        "type" : null,
        "defaultValue" : null,
        "validateType" : "",
        "error" : "",
        "expression" : "",
        "children" : [ {
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
            "name" : "id",
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
          }, {
            "name" : "name",
            "value" : "修改的名称2",
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
            "name" : "desc",
            "value" : "测试",
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
            "name" : "userid",
            "value" : "1",
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
            "name" : "personal",
            "value" : "false",
            "description" : "",
            "required" : false,
            "dataType" : "Boolean",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "user_simple",
            "value" : "",
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
            "name" : "dialog_id",
            "value" : "22",
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
            "name" : "archived_at",
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
            "name" : "archived_userid",
            "value" : "0",
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
            "name" : "created_at",
            "value" : "1705023798000",
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
            "name" : "updated_at",
            "value" : "1705028450000",
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
            "name" : "deleted_at",
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
            "name" : "owner",
            "value" : "1",
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
            "name" : "userid_list",
            "value" : "",
            "description" : "",
            "required" : false,
            "dataType" : "Array",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          } ]
        } ]
      }, {
        "name" : "total_all",
        "value" : "1",
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
    }, {
      "name" : "timestamp",
      "value" : "1708015019611",
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
      "value" : "46",
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
//拦截用户部分没处理
import log
import 'cn.dev33.satoken.stp.StpUtil';
var userid = StpUtil.getLoginId()
// var userid = 6
log.info("userid is->" + userid)
//各种判断还有统计
log.info("archived is->" + archived)

//查找是自己负责或者自己创建的项目   TODO  owner怎么填

var projects = db.select("""
    SELECT
        p.*,
        pu.owner
    FROM
        project_users pu 
    JOIN
        projects p  ON p.id = pu.project_id
    WHERE
        pu.userid = #{userid} 
    AND 
        p.deleted_at IS  NULL
""")

//处理用户列表
if (getuserid != null) {
     log.info(getuserid)
    //遍历项目列表，增加userid_list列，罗列用户列表
    for (item in projects) {
        //获取用户成员
        userListQuery = db.table("project_users").where().eq("project_id", item.id).select()
        let useridList = []
        for (item in userListQuery) {
            useridList.push(userListQuery.userid)
        }
        log.info("useridList .size:::::+"+useridList.size())
        item.owner = item.userid
        item.userid_list = useridList
    }
}

var data = {
    data,
    total_all
}

data.data = projects
data.total_all = projects.size()
return data