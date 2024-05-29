package org.ssssssss.magicboot.model;

import cn.hutool.core.util.StrUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.ssssssss.magicboot.utils.WebUtils;

@Component
public class Global {

    /**
     * 文件上的根目录
     */
    public static String dir;

    public final static String USER_FILES_BASE_URL = "/userfiles/";

    public static String getDir() {
        return dir;
    }

    @Value("${upload.dir:D:/mb/}")
    public void setDir(String dir) {
        this.dir = dir;
    }

    /**
     * 获取上传文件的根目录
     *
     * @return
     */
    public static String getUserFilesBaseDir() {
        String dir = getDir();
        if (StrUtil.isBlank(dir)) {
            try {
                dir = WebUtils.getHttpServletRequest().getSession().getServletContext().getRealPath("/");
            } catch (Exception e) {
                return "";
            }
        }
        if (!dir.endsWith("/")) {
            dir += "/";
        }
        return dir;
    }

}
