package com.index.rest.controller;

import com.index.cache.redis.RedisCache;
import com.index.core.auth.UserService;
import com.index.core.id.Snowflake;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("test")
public class TestController {

    @Autowired
    private Snowflake snowflake;

    @Autowired
    private UserService userService;


    @GetMapping("/seq")
    public String getseq() {
        return Long.toBinaryString(snowflake.next());
    }

    @GetMapping("/user")
    public String getU() {
        return userService.test();
    }


}
