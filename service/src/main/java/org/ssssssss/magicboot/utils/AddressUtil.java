package org.ssssssss.magicboot.utils;

import cn.hutool.core.net.Ipv4Util;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONUtil;

public class AddressUtil {

    public static String getAddress(String ip){
        try {
            if(Ipv4Util.isInnerIP(ip)){
                return "内网IP";
            }
            return JSONUtil.parseObj(HttpUtil.get("https://whois.pconline.com.cn/ipJson.jsp?json=true&ip=" + ip)).getStr("addr");
        }catch(IllegalArgumentException e){
            return "内网IP";
        }catch(Exception e){
            return "未知";
        }
    }

}
