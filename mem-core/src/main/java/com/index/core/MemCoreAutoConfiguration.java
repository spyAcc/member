package com.index.core;


import com.index.cache.redis.RedisCache;
import com.index.core.config.CoreSettings;
import com.index.core.id.Snowflake;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

/**
 * core 模块作为一个 starer pom 来定义， core有自己的配置类， 不影响业务系统的配置类， 可以像插件一样
 */
@Configuration
@ComponentScan
@EnableConfigurationProperties(CoreSettings.class)
public class MemCoreAutoConfiguration {

    @Autowired
    private CoreSettings coreSettings;

    @Bean
    @ConditionalOnClass(Snowflake.class)
    @ConditionalOnMissingBean(Snowflake.class)
    public Snowflake snowflake() {
        return new Snowflake(this.coreSettings.getWorkId(), this.coreSettings.getGroupId());
    }

}
