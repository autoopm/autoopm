{
  "properties" : { },
  "id" : "50aa4204a27c40198e30d90a1dc96956",
  "script" : null,
  "groupId" : "07213facdab54280b6ba7b4637732337",
  "name" : "保存任务正文内容",
  "createTime" : 1716867162918,
  "updateTime" : 1716882660016,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/saveContent",
  "description" : null,
  "returnType" : null,
  "mappingPath" : null,
  "parameters" : [ {
    "name" : "content",
    "value" : null,
    "description" : "内容",
    "required" : false,
    "dataType" : "String",
    "type" : "java.lang.String",
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "type",
    "value" : null,
    "description" : "操作类型  add-添加 update 更新 ",
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
import log
import 'cn.hutool.http.HtmlUtil';
import 'cn.hutool.core.util.ReUtil';
import 'org.ssssssss.magicboot.utils.MinioUtil';
import 'org.ssssssss.magicboot.utils.FileUtils';
import cn.hutool.core.util.StrUtil;
import env
var ip = env.get("public.ip")
log.info("ip-->" + serviceUrl);

log.info("获取的content value is " + content)
log.info("获取的type value is " + type)
//先处理

let textWithoutHtml = HtmlUtil.cleanHtmlTag(content);
log.info(textWithoutHtml)

// path = "uploads/task/content/" + now() + "/" + taskId + "/"; //基础的地址，修改成按月份
regex = "<img\\s+src=\"data:image/(png|jpg|jpeg|webp);base64,(.*?)\"";

let allList = []
ReUtil.findAll(regex, content, 0, allList) //全部
for (item in allList) {
    log.info("allList -->" + item)
}

let group1List = []
ReUtil.findAll(regex, content, 1, group1List) //类型
for (item in group1List) {
    log.info("group1List -->" + item)
}

let group2List = []
ReUtil.findAll(regex, content, 2, group2List) //base64
log.info("group2List size  -->" + group2List.size())

for (index, item in group2List) {
    log.info("group2List -->" + item)
    var url = MinioUtil.uploadBase64(item)
    log.info("保存图片到minio中" + url)
    prewUrl = MinioUtil.preview(url)
    log.info("图片真实地址:" + prewUrl)
    preview = StrUtil.replaceChars(prewUrl, "task-minio", ip) //TODO 这里需要特殊处理
    log.info("处理后的图片真实地址:" + prewUrl)


    // let imgInfo = FileUtils.getImageSize('https://s2.51cto.com/blog/activity/bride/DetailsBride.gif?x-oss-process=image/ignore-error,1')
    var imgInfo = FileUtils.getImageSize(prewUrl)
    //组装url
    lastUrl = '<img src="' + prewUrl + '" original-width="' + imgInfo[0] + '" original-height="' + imgInfo[1] + '"'
    log.info("lastUrl-->" + lastUrl)
    content = content.replace(allList[index], lastUrl)
}


//这里不需要进行替换操作了，直接展示吧
//TODO minio保存文件的方法
textUrl = MinioUtil.uploadTxt(content)
log.info("textUrl" + textUrl)
// resultUrl = MinioUtil.preview(textUrl) //TODO URL这里不处理了。直接按资源名，这样子才能取得
resultUrl = textUrl
log.info("resultUrl Url" + resultUrl)

// var result = db.table('project_task_contents').primary('project_id').primary('task_id').update({
//     project_id: project_id,
//     task_id: task_id,
//     content: contentValue::json //  这里存json
// })
// log.info("insert ->result:", result)

return resultUrl

//TODO 文件存储操作

// $path = 'uploads/task/content/' . date("Ym") . '/' . $task_id . '/';
//     //
//     preg_match_all("/<img\s+src=\"data:image\/(png|jpg|jpeg|webp);base64,(.*?)\"/s", $content, $matchs);
//     foreach ($matchs[2] as $key => $text) {
//         $tmpPath = $path . 'attached/';
//         Base::makeDir(public_path($tmpPath));
//         $tmpPath .= md5($text) . "." . $matchs[1][$key];
//         if (Base::saveContentImage(public_path($tmpPath), base64_decode($text))) {
//             $paramet = getimagesize(public_path($tmpPath));
//             $content = str_replace($matchs[0][$key], '<img src="{{RemoteURL}}' . $tmpPath . '" original-width="' . $paramet[0] . '" original-height="' . $paramet[1] . '"', $content);
//         }
//     }
//     $pattern = '/<img(.*?)src=("|\')https*:\/\/(.*?)\/(uploads\/task\/content\/(.*?))\2/is';
//     $content = preg_replace($pattern, '<img$1src=$2{{RemoteURL}}$4$2', $content);
//     //
//     $filePath = $path . md5($content);
//     $publicPath = public_path($filePath);
//     Base::makeDir(dirname($publicPath));
//     file_put_contents($publicPath, $content);
//     //
//     return $filePath;

// log.info('content ->' + body.content);
// log.info('contentValue ->' + contentValue);
// var result = db.table('project_task_contents').insert({
//     project_id: useTask.project_id,
//     task_id: useTask.task_id,
//     content: contentValue
// })
// log.info("插入详细描述", result)
// var logDetail = '修改任务详细描述'
// var project_log = db.table('project_logs').insert({
//     project_id: useTask.project_id,
//     column_id: 0,
//     task_id: useTask.task_id,
//     userid: userid,
//     detail: logDetail
// })
// log.info("插入详细描述日志", project_log)


//TODO $updateMarking['is_update_content'] = true;
// //处理详情描述
// var contentValue = {}

// contentValue.url = ''
// var contentId = db.table('project_task_contents').primary('project_id').primary('task_id').update({
//     project_id: project_id,
//     task_id: task_id,
//     content: contentValue::json //  这里存json
// })


// return "调用保存内容正文正确"