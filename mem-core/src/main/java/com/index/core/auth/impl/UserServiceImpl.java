package com.index.core.auth.impl;

import com.index.cache.redis.RedisCache;
import com.index.core.auth.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired(required = false)
    private RedisCache redisCache;

    @Override
    public String test() {
        if(redisCache != null)
            return "userService";
        return "not found";
    }
}
