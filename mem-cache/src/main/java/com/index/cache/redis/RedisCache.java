package com.index.cache.redis;

import redis.clients.jedis.JedisPool;

/**
 * 操作redis类
 */
public class RedisCache {

    private JedisPool pool;

    public RedisCache(JedisPool pool) {
        this.pool = pool;
    }




}
