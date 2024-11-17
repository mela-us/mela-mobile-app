package com.hcmus.mela.service;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class RedisTestRunner implements CommandLineRunner {

    private final RedisTestService redisTestService;

    public RedisTestRunner(RedisTestService redisTestService) {
        this.redisTestService = redisTestService;
    }

    @Override
    public void run(String... args) {
        redisTestService.testRedis();
    }
}

