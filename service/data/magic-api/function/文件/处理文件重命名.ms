{
  "properties" : { },
  "id" : "2308e266c5b84ba58da6c365d5d33b63",
  "script" : null,
  "groupId" : "89c986b52b04478a95630c451428ab00",
  "name" : "处理文件重命名",
  "createTime" : 1716867163259,
  "updateTime" : 1711784127593,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/handleDuplicateName",
  "description" : "处理名称重复的情况，返回新的名称",
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ {
    "name" : "pid",
    "value" : null,
    "description" : "父id",
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.Number",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "userid",
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
  }, {
    "name" : "ext",
    "value" : null,
    "description" : "后缀",
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.String",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "name",
    "value" : null,
    "description" : "文件名称",
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.String",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ]
}
================================
import java.util.Random;
import java.util.regex.Pattern;

var nameNum = db.table("files")
    .where()
    .isNull('deleted_at')
    .eq('pid', pid)
    .eq('userid', userid)
    .eq('ext', ext)
    .eq('name', name)
    .count();

if (nameNum == 0) {
    // 未重名，不需要处理
    return name;
}

// 发现重名，开始自动重命名
var nextNum = 2;
// 如果文件名符合 "文件名 (数字)" 格式，则提取文件名前缀和数字部分
if (Pattern.matches("(.*?)(\\s+\\(\\d+\\))*$", name)) {
    // 使用正则表达式提取文件名前缀
    String preName = name.replaceAll("(.*?)(\\s+\\(\\d+\\))*$", "$1");
    // 查询已存在的类似文件名的数量
    nextNum = db.selectInt("""select count(1) from files where name like CONCAT(#{preName},'%') and deleted_at is null""") + 1;
}

// 组合新的文件名
String newName = name + " (" + nextNum + ")";

var nameIsExists = db.select("""
SELECT EXISTS (SELECT 1 FROM files WHERE name = #{newName} and deleted_at is null) as nameIsExists;
""");

// 如果新文件名已存在，则随机生成数字直到新文件名唯一
while (nameIsExists.nameIsExists == 1) {
    nextNum = new Random().nextInt(9900) + 100; // 生成 100-9999 之间的随机数
    newName = name + " (" + nextNum + ")";
    nameIsExists = db.select("""
    SELECT EXISTS (SELECT 1 FROM files WHERE name = #{newName} and deleted_at is null) as nameIsExists;
    """);
}

return newName;