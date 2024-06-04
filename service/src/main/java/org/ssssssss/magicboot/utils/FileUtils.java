package org.ssssssss.magicboot.utils;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import org.springframework.web.multipart.MultipartFile;
import org.ssssssss.magicboot.model.Global;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class FileUtils {

    public static Map<String, String> createFileAttr(String originalFilename){
        String ret = Global.USER_FILES_BASE_URL + DateUtil.today() + "/" + IdUtil.simpleUUID() + "/";
        String suffix = FileUtil.getSuffix(originalFilename);
        Map<String, String> map = new HashMap<>();
        map.put("ret", ret);
        map.put("filePath", ret.substring(1) + originalFilename);
        map.put("fileNames", originalFilename);
        map.put("suffix", suffix);
        return map;
    }

    public static Map<String, String> saveFile(MultipartFile file) {
        Map<String, String> fileAttr = createFileAttr(file.getOriginalFilename());
        String fileNames = fileAttr.get("fileNames");
        String ret = fileAttr.get("ret");
        String suffix = fileAttr.get("suffix");
        String realPath = Global.getUserFilesBaseDir() + ret;
        FileUtil.mkdir(FileUtil.normalize(realPath));
        File tempFile = new File(realPath + fileNames);
        if (!tempFile.getParentFile().exists()) {
            tempFile.getParentFile().mkdir();
        }
        try {
            if (!tempFile.exists()) {
                file.transferTo(tempFile);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
		Map<String, String> params = new HashMap<>();
		params.put("state", "SUCCESS");
		params.put("original", file.getName());
		params.put("name", file.getName());
		params.put("size", file.getSize() + "");
      	params.put("type", suffix);
      	params.put("url", fileAttr.get("filePath"));
      	return params;
	}

}
