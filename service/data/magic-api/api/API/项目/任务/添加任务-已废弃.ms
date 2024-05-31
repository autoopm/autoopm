{
  "properties" : { },
  "id" : "5039c6a3a36f4eeab48b10476b8728c0",
  "script" : null,
  "groupId" : "f2a82a98ff1d49a3904430542a3d776d",
  "name" : "添加任务-已废弃",
  "createTime" : 1717060653825,
  "updateTime" : 1713024594161,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/add",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ ],
  "requestBody" : "{\n  \"cascader\": [\n    84,\n    181\n  ],\n  \"name\": \"12313\",\n  \"content\": \"<p>31313</p>\",\n  \"owner\": [\n    1\n  ],\n  \"assist\": [],\n  \"project_id\": 84,\n  \"column_id\": 181,\n  \"times\": [\n    \"2024-01-27 09:00\",\n    \"2024-01-28 18:00\"\n  ],\n  \"subtasks\": [],\n  \"p_level\": 1,\n  \"p_name\": \"重要且紧急\",\n  \"p_color\": \"#ED4014\",\n  \"visibility_appoint\": 1,\n  \"visibility_appointor\": []\n}",
  "headers" : [ {
    "name" : "token",
    "value" : "03be7949-9a0f-4a49-be4c-1831527749e0",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "Content-Type",
    "value" : "application/json",
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
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": null,\n    \"timestamp\": 1706326527141,\n    \"executeTime\": 35\n}",
  "description" : null,
  "requestBodyDefinition" : {
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
      "name" : "cascader",
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
        "value" : "84",
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
      "name" : "name",
      "value" : "12313",
      "description" : "",
      "required" : true,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "content",
      "value" : "<p>31313</p>",
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
      "name" : "owner",
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
      "name" : "assist",
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
    }, {
      "name" : "project_id",
      "value" : "84",
      "description" : "",
      "required" : true,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "column_id",
      "value" : "181",
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
      "name" : "times",
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
        "value" : "2024-01-27 09:00",
        "description" : "",
        "required" : false,
        "dataType" : "String",
        "type" : null,
        "defaultValue" : null,
        "validateType" : "",
        "error" : "",
        "expression" : "",
        "children" : [ ]
      } ]
    }, {
      "name" : "subtasks",
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
    }, {
      "name" : "p_level",
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
      "name" : "p_name",
      "value" : "重要且紧急",
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
      "name" : "p_color",
      "value" : "#ED4014",
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
      "name" : "visibility_appoint",
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
      "name" : "visibility_appointor",
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
  },
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
      "value" : "1706029998978",
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
      "value" : "278",
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

//判断个人项目是否已经存在
var userid = StpUtil.getLoginId()
log.info("userid is" + userid)

var projectId = body.project_id
var columnId = body.column_id

//判断项目是否已归档，自己在不在项目中
var useProject = db.table("projects").where().eq("id", projectId).notNull("archived_at").selectOne()
if (useProject == null) {
    exit 400, '项目不存在或已归档'
}

if (body.name.length() == 0) {
    exit 400, '描述不能为空'
}

if (body.content.length() > 255) {
    exit 400, '描述最多只能设置255个字'
}

var column
var newColumn
//获取列表对应的列表信息
if (columnId) {
    log.info('进到这里column_id：' + columnId);
    if (columnId > 0) {
        //从项目任务列表中找到那个列表
        column = db.table("project_columns").where().eq("project_id", projectId).eq("id", columnId).selectOne()
    }
    //如果还是找不到列表，试着用column_id作为名字去查找
    if (column == null) {
        column = db.table("project_columns").where().eq("project_id", projectId).eq("name", columnId).selectOne()
    }
} else {
    //如果没有则使用第一个任务列表
    column = db.table("project_columns").where().eq("project_id", projectId).orderBy("id").selectOne()
}
//如果再没有则创建新的
if (column == null) {
    log.info('column is null')
    var tempColumnName
    if (columnId == null) {
        tempColumnName = 'Default'
    }
    sort = 0
    //设置排序
    var columnResult = db.table("project_columns").where().eq("id", projectId).orderByDesc('sort').selectOne()
    if (columnResult != null) {
        sort = columnResult.sort + 1
        log.info('sort is' + sort)
    }
    var result = db.table('project_columns').insert({
        project_id: projectId,
        name: tempColumnName,
        sort: sort,
    })
    log.info('插入任务列表的结果：' + result)
    //创建创建列表日志
    var logDetail = '创建列表' + tempColumnName
    var project_log = db.table('project_logs').insert({
        project_id: projectId,
        column_id: 0,
        task_id: 0,
        userid: userid,
        detail: logDetail
    })
    newColumn = db.table("project_columns").where().eq("id", result).selectOne()
    newColumn.project_task = []
}
if (newColumn = null) {
    exit 400, '任务列表不存在或已被删除'
}


var flowItemId
var flowItemName

//工作流处理
var projectFlow = db.table("project_flows").where().eq("project_id", projectId).selectOne()
log.info('projectFlow:' + projectFlow)


if (projectFlow != null) { //开启工作流的项目
    var projectFlowItem = db.table("project_flow_items").where().eq("flow_id", projectFlow.id).select()
    log.info('projectFlowItem:' + projectFlowItem)
    //赋开始状态
    for (item in projectFlowItem) {
        if (item.status == 'start') {
            flowItemId = item.id
            flowItemName = item.status + '|' + item.name
        }
    }

} else { //未开始工作流的项目


}

//插入任务表
var taskResult = db.table('project_tasks').insert({
    parent_id: 0, //如果有子任务这里要修改
    project_id: projectId,
    column_id: column.id,
    name: body.name,
    userid: userid,
    flow_item_id: flowItemId,
    flow_item_name: flowItemName,
    //优先级相关
    p_level: p_level,
    p_name: p_name,
    p_color: p_color,
    //排序
})
log.info('taskResult:' + taskResult)
//插入任务用户表
var val = db.transaction(() => {
    //TODO 创建者的逻辑
    var owner = 1
    var result = db.table('project_task_users').insert({
        project_id: projectId,
        task_id: taskResult,
        task_pid: taskResult,
        userid: userid,
        owner: owner
    })

    //可见性先不考虑了
    //子任务也先不考虑了
    log.info('插入任务用户表结果' + result)

})


log.info('插入任务表' + result)
var data = db.table("project_tasks").where().eq("id", result).selectOne()
//TODO 下面这部分应该不会出现，一边创建项目一边创建任务列表

// 可见性设置
// 首次聊天后才会创建聊天室，所以这里不创建聊天室
// if(newColumn){
//      //将data 转成数组
//      data.new_column = newColumn
// }
//推送消息
return data