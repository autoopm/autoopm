{
  "properties" : { },
  "id" : "74de858268e543a5a4deb99f8865fd87",
  "script" : null,
  "groupId" : "89c986b52b04478a95630c451428ab00",
  "name" : "检查复制文件名",
  "createTime" : null,
  "updateTime" : 1718173619053,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/checkCopy",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ {
    "name" : "file_url",
    "value" : null,
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ]
}
================================

// import org.ssssssss.magicboot.utils.MinioUtil;
// let fileName = file_url.substring(0, file_url.lastIndexOf('.'));
// let fileExtension = file_url.substring(file_url.lastIndexOf('.'));
// let counter = 1;

//   let fileName = `${baseName}_copy${extension}`;  

//   // 假设我们有一个函数来检查文件是否已存在（这通常是不可能的，除非你有FileSystem API权限）  
//   // 这里我们只是模拟检查过程  
//   function checkFileExists(fileName) {  
//     // 这是一个模拟函数，实际情况中你需要根据具体情况来实现检查逻辑  
//     // 例如，你可能需要发送一个请求到服务器来检查文件是否存在  
//     // 这里我们简单地根据counter值来判断  
//     return counter > 1; // 假设除了第一个文件外，其他都“存在”  
//   }  
  
//   // 循环直到找到一个不存在的文件名  
//   while (checkFileExists(fileName)) {  
//     fileName = `${baseName}_copy${counter++}${extension}`;  
//   }  
  
//   // 返回带有目标目录（如果需要）的完整文件名  
//   return `${targetDir}${fileName}`;  


