package com.index.cache;

import com.index.cache.config.CacheSettings;
import com.index.cache.redis.RedisCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

@Configuration
@EnableConfigurationProperties(CacheSettings.class)
@ConditionalOnProperty(prefix = "mem.cache", value = "enable")
public class MemCacheAutoConfiguration {

    @Autowired
    private CacheSettings cacheSettings;

    @Bean
    @ConditionalOnClass(RedisCache.class)
    @ConditionalOnMissingBean(RedisCache.class)
    public RedisCache redisCache() {
        return new RedisCache(this.redisPoolFactory());
    }


    @Bean
    @ConditionalOnClass(JedisPool.class)
    @ConditionalOnMissingBean(JedisPool.class)
    public JedisPool redisPoolFactory(){
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();

        jedisPoolConfig.setMaxIdle(this.cacheSettings.getMaxIdle());
        jedisPoolConfig.setMaxTotal(this.cacheSettings.getMaxActive());
        jedisPoolConfig.setMinIdle(this.cacheSettings.getMixIdle());

        JedisPool jedisPool = new JedisPool(jedisPoolConfig, this.cacheSettings.getHost(),
                this.cacheSettings.getPort(), this.cacheSettings.getTimeout(),
                this.cacheSettings.getPassword(), this.cacheSettings.getDatabase() );

        return  jedisPool;
    }


}
