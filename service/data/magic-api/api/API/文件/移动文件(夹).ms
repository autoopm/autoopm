{
  "properties" : { },
  "id" : "11942a42c5b5480f82aa3ccfd940d8e3",
  "script" : null,
  "groupId" : "7cc0839b044d4ab3a208aaf2142fbd7f",
  "name" : "移动文件(夹)",
  "createTime" : 1717060653008,
  "updateTime" : 1716773736027,
  "lock" : "0",
  "createBy" : null,
  "updateBy" : null,
  "path" : "/move",
  "method" : "GET",
  "parameters" : [ {
    "name" : "pid",
    "value" : null,
    "description" : "移动到的文件夹ID",
    "required" : true,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "ids",
    "value" : null,
    "description" : "移动的文件夹ID",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "expression",
    "error" : "请选择移动的文件或文件夹",
    "expression" : "ids == null ||ids == \"\"",
    "children" : null
  } ],
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
import cn.hutool.core.util.StrUtil;
import '@/file/permissionFind' as permissionFind;
import '@/file/handleDuplicateName' as handleDuplicateName;

// 检查一次移动的文件或文件夹数量是否超过限制（100个）
var idList = StrUtil.split(ids, ',');
if (idList.size() > 100) {
    exit 400, '一次最多只能移动100个文件或文件夹';
}

// 判断是否移动到共享文件夹
var toShareFile = false;
var tmpShareFile = null;
if (pid > 0) {
    // 检查目标文件夹是否存在以及用户是否有权限
    tmpShareFile = permissionFind(pid, userId, 1);
    // 如果目标是一个共享文件夹，则获取共享信息
    toShareFile = tmpFile.share == 1;
}

// 定义一个数组用于存储移动的文件对象
var files = [];
// 使用数据库事务处理移动操作
var val = db.transaction(() => {
    for (id in idList) {
        // 获取文件对象并检查用户是否有权限
        var file = permissionFind(id, userId, 1000);

        if (pid > 0) {
            // 如果移动到的是一个共享文件夹
            if (toShareFile) {
                // 检查文件是否已经在共享中或者包含共享文件
                if (file.share == 1) {
                    exit 400, '当前正在共享，无法移动到另一个共享文件夹内';
                }

                // 如果当前是文件夹，就检查当前文件夹下面是否有子项（文件或文件夹）被共享。
                if ("folder".equals(file.type)) {
                    var currIdPath = file.id_path;
                    var subShareNum = db.selectInt("""
                    select count(*) from files where share=1 and id_path LIKE CONCAT( #{currIdPath}, '%' ) 
                    """)

                    if (subShareNum > 0) {
                        exit 400, file.name + '内含有共享文件，无法移动到另一个共享文件夹内';
                    }

                }

                // 更新当前文件以及所有子文件的用户ID为共享文件夹的用户ID
                var userid = tmpShareFile.userid;
                var currIdPath = file.id_path;
                db.update("""update files set userid = #{userid} where id_path LIKE CONCAT( #{currIdPath}, '%' )""")
            }

            // 确保文件不是移动到自己的子文件夹中
            var tmpId = pid;
            while (tmpId > 0) {
                if (id == tmpId) {
                    exit 400, '移动位置错误';
                }
                tmpId = db.table('magic_api_info')
                    .column('pid')
                    .where()
                    .eq('id', tmpId)
                    .selectOne()
            }
        } else {
            // 如果移动到的根文件夹
            // 更新当前文件以及所有子文件的用户ID为共享文件夹的用户ID
            var userid = StpUtil.getLoginId();
            var currIdPath = file.id_path;
            db.update("""update files set userid = #{userid} where id_path LIKE CONCAT( #{currIdPath}, '%' )""")
        }

        // 处理重名
        var newName = handleDuplicateName(pid, userId, ext, trimmedName);
        // 更新
        db.table('files').primary('id').update({
            id: file.id,
            pid: pid,
            name: newName
        })

        var newPshare = 0;
        var currIdPath = file.id_path;
        if (pid != 0) {
            // 如果要移动的文件(夹)处于共享当中或不是共享,移动到的目标是共享的，把当前文件(夹)的pshare变成目标文件夹的id
            if (file.share == 0 && tmpShareFile.share == 1) {
                newPshare = tmpShareFile.id;
            }
            // 如果要移动的文件(夹)处于共享当中或不是共享,移动到的目标是处于共享中，把当前文件(夹)的pshare变成目标文件夹的pshare
            if (file.share == 0 && tmpShareFile.share == 0 && tmpShareFile.pshare != 0) {
                newPshare = tmpShareFile.pshare;
            }

            // 如果要移动的文件(夹)处于共享当中,移动到的目标是不是共享中，把当前文件(夹)的pshare变成0
            if (file.share == 0 && tmpShareFile.share == 0 && tmpShareFile.pshare == 0) {
                newPshare = 0;
            }

        } else {
            // 处理文件(夹)处于共享中的，把当前文件(夹)的pshare变成0
            if (file.share == 0 && file.pshare != 0) {
                newPshare = 0;
            }
        }

        // 批量更新pshare
        db.update(""" update files set pshare = #{newPshare} where id_path LIKE CONCAT( #{currIdPath}, '%' )""")


        // 处理pids和id_path,内存构建，批量更新
        var updateFileList = db.select("""
        select id,id_path,pid from files where id_path LIKE CONCAT( #{currIdPath}, '%' )
        """);

        var updateFiles = [];
        var swapPidStr = "";
        if (pid != 0) {
            swapPidStr = tmpShareFile.id_path + file.id + "/"
        } else {
            swapPidStr = "/" + file.id + "/"
        }

        for (item in updateFileList) {
            // 使用replace方法替换字符串中的指定子串
            var newIdPath = item.id_path.replace(file.id_path, swapPidStr);
            updateFiles.add([newIdPath, newIdPath, item.id]);
        }

        db.batchUpdate("""update files set id_path = ?,pids=? where id = ?""", updateFiles);
        // 将文件对象添加到数组中
        files.add(file);

    }
});

return files;