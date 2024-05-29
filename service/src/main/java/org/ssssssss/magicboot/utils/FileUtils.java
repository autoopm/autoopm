package org.ssssssss.magicboot.utils;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.http.HttpUtil;
import org.springframework.web.multipart.MultipartFile;
import org.ssssssss.magicboot.model.Global;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.*;

public class FileUtils {

    public static Map<String, String> createFileAttr(String originalFilename) {
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

    /**
     * 获取图片的高宽
     *
     * @param imageUrl
     * @return
     */
    public static List<Integer> getImageSize(String imageUrl) {

        File tempFile = FileUtil.file("temp.jpg");
        HttpUtil.downloadFile(imageUrl, tempFile);
        List<Integer> list = new ArrayList<>();
        // 读取临时文件中的图片，获取图片尺寸
        try {
            BufferedImage image = ImageIO.read(tempFile);
            int width = image.getWidth();
            int height = image.getHeight();
            list.add(width);
            list.add(height);
            System.out.println("图片宽度：" + width);
            System.out.println("图片高度：" + height);
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;

    }

    /**
     * 获取文件大小，单位b
     * @param fileUrl 文件网络路径
     * @return 文件大小，单位b
     */
    public static long getFileSize(String fileUrl) {
        // 创建临时文件
        File tempFile = FileUtil.file("temp-size.word");
        // 下载文件到临时文件
        HttpUtil.downloadFile(fileUrl, tempFile);
        // 获取文件大小
        long size = FileUtil.size(tempFile);
        return size;
    }

}
