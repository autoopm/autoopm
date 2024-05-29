package org.ssssssss.magicboot.model;

import java.util.HashMap;
import java.util.Map;

public class CodeCacheMap {

    private static Map<String, String> map = new HashMap<String, String>();

    public static void put(String key, String value){
        map.put(key, value);
    }

    public static void remove(String key){
        map.remove(key);
    }

    public static String get(String key){
        return map.get(key);
    }

}
