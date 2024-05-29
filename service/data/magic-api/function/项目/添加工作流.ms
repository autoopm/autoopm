{
  "properties" : { },
  "id" : "631d203dee1042fea99547aa0168e4fb",
  "script" : null,
  "groupId" : "f1893ea1928d488999804afc6c84e785",
  "name" : "添加工作流",
  "createTime" : 1716867164250,
  "updateTime" : 1713024595683,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/addFlow",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ {
    "name" : "flows",
    "value" : null,
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : "java.util.Collection",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "projectId",
    "value" : null,
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.Object",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ]
}
================================
import log
log.info("this project_id --> " + projectId)
log.info("this flows --> " + flows)
var val = db.transaction(() => {
    //判断是否存在了工作流  
    var projectFlowId
    projectFlow = db.table("project_flows").where().eq("project_id", projectId).selectOne()
    if (!projectFlow) {
        log.info("项目流程不存在则创建")
        //创建工作流, 这样能不能等于还是未知
        projectFlowId = db.table('project_flows').insert({
            project_id: projectId,
            name: 'Default',
        })
        if (!projectFlowId) {
            exit 400, '工作流创建失败'
        }
    } else {
        projectFlowId = projectFlow.id
    }
    //一个项目只存在一个流程
    projectFlow = db.table("project_flows").where().eq("project_id", projectId).selectOne()

    idc = []
    upTaskList = []
    ids = [];
    hasStart = false //是否有开始状态
    hasEnd = false //是否有结束状态
    sort = -1 //排序

    for (item in flows) {
        sort = sort + 1
        item_id = item.id
        log.info('item_id： ' + item_id)
        item_usertype = item.usertype
        item_userids = item.userids //TODO 判断空值
        item_userlimit = item.userlimit
        item_turns = item.turns //TODO 判断空值
        if (usertype == 'replace' && item_userids.size() < 1) {
            exit 400, "状态[" + item.name + ']设置错误，设置流转模式时必须填写状态负责人'
        }
        if (usertype == 'merge' && item_userids.size() < 1) {
            exit 400, "状态[" + item.name + ']设置错误，设置剔除模式时必须填写状态负责人'
        }
        if (userlimit && item_userids.size() < 1) {
            exit 400, "状态[" + item.name + ']设置错误，设置限制负责人时必须填写状态负责人'
        }
        log.info("projectFlowId is" + projectFlowId)
        log.info('turns is ' + item_turns)
        log.info('item_userids ' + item_userids)

        updateInsertResult = 0
        //更新或插入数据库，怎么判断呢？
        if (item.id > 0) { //更新操作
            //更新数据库
            ids.push(item.id) // 在这里直接添加了
            result = db.table('project_flow_items').primary("id").save({
                id: item.id,
                flow_id: projectFlowId,
                project_id: projectId,
                name: item.name,
                status: item.status,
                sort: sort, // 暴力排序
                usertype: item_usertype,
                userlimit: item_userlimit,
                turns: item_turns::string,
                userids: item_userids,
            })
        } else { //新建操作
            result = db.table('project_flow_items').insert({
                flow_id: projectFlowId,
                project_id: projectId,
                name: item.name,
                status: item.status,
                sort: sort, // 暴力排序
                usertype: item_usertype,
                userlimit: item_userlimit,
                turns: item_turns::string,
                userids: item_userids,
            })
            log.info("新建操作的返回值->" + result)
            ids.push(result)
        }

        // //插入数据库
        // var insertId = db.table('project_flow_items').insert({
        //     name: item.name,
        //     status: item.status,
        //     sort: sort, // 暴力排序
        //     flow_id: projectFlowId,
        //     project_id: projectId,
        //     usertype: item_usertype,
        //     userlimit: item_userlimit,
        //     turns: item_turns,
        //     userids: item_userids,
        // })

        // log.info("updateInsertResult value :" + updateInsertResult)
        // if (updateInsertResult > 0) {
        // ids.push(updateInsertResult)
        // log.info("插入或更新成功 :" + updateInsertResult + "|" + ids)
        // $ids[] = $flow->id;
        //         if ($flow->id != $id) {
        //             $idc[$id] = $flow->id;
        //         }
        if (item.status == 'start') {
            hasStart = true
        }
        if (item.status == 'end') {
            hasEnd = true
        }
        //记录哪些任务的状态描述需要更新，插入为新值的不用管，新状态因为任务还没存在
        if (item.id > 0) {
            upTaskList.push({
                flow_id: item.id,
                statusStr: item.status + "|" + item.name
            })
            log.info("upTaskList", upTaskList::string)
        }
        // }
    }
    if (!hasStart) {
        exit 400, '至少需要1个开始状态'
    }
    if (!hasEnd) {
        exit 400, '至少需要1个结束状态'
    }

    // 查询工作流项中没有的，进行删除操作
    noInFlowItems = db.table("project_flow_items").where().eq("project_id", projectId).notIn("id", ids).select()
    for (item in noInFlowItems) {
        result = db.table("project_flow_items").where().eq("project_id", projectId).eq("id", item.id).delete()
        log.info("删除不存在的项 result" + result)
    }

    //修改任务表中该状态的状态显示
    for (item in upTaskList) {
        result = db.table("project_tasks").primary("flow_item_id").update({
            flow_item_id: item.flow_id,
            flow_item_name: item.statusStr
        })
        log.info("修改任务的状态显示" + result)
    }

    //重新排序
    ids = ids.sort((a, b) => a - b);
    log.info("ids 重新排序" + ids::string)

    //修改成最新的
    for (item in ids) {
        db.table('project_flow_items').primary('id').update({
            id: item,
            turns: ids::string,
        })
    }



    // //取出所有的item项
    // flowItemList = db.table("project_flow_items").where().eq("project_id", projectId).orderBy("sort").select()
    // let itemIds = []
    // for (item in flowItemList) {
    //     itemIds.push(item.id)
    // }

    // log.info("itemIds" + itemIds)
    //将idc进行排序
    // for (item in flowItemList) {
    //排序
    // itemIds = itemIds.sort((a, b) => a - b); //从小到大
    // log.info("itemIds 重新排序" + itemIds::string) //TODO 能不能放到循环外面呢
    // foreach ($idc as $oid => $nid) {
    //             if (in_array($oid, $turns)) {
    //                 $turns = array_diff($turns, [$oid]);
    //                 $turns[] = $nid;
    //             }
    //         }
    //         if (!in_array($item->id, $turns)) {
    //             $turns[] = $item->id;
    //         }
    //         $turns = array_values(array_filter(array_unique(array_intersect($turns, $itemIds))));
    //         sort($turns);
    //         $item->turns = $turns;
    //更新
    flowItemList = db.table("project_flow_items").where().eq("project_id", projectId).orderBy("sort").select()
    for (item in flowItemList) {
        log.info("flowItemList  item ------" + item)
    }
    // return flowItemList
    projectFlow.project_flow_item = flowItemList
    return projectFlow
});
return val


//排序后再返回
// //更新turns的值
// log.info("ids" + ids)
// for (item in ids) {
//     db.table('project_flow_items').primary('id').update({
//         id: item,
//         turns: ids::string,
//     })
// }

// return val;

// return []