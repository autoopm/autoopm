package org.ssssssss.magicboot.controller;

import cn.dev33.satoken.stp.StpUtil;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test")
public class TestController {
    @RequestMapping("/test")
    public void test(){
        Object loginId = StpUtil.getLoginId();
        System.out.println(loginId);
    }
}
