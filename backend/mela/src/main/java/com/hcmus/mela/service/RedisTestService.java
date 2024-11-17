package com.hcmus.mela.service;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

@Service
public class RedisTestService {

    private final RedisTemplate<String, Object> redisTemplate;

    public RedisTestService(RedisTemplate<String, Object> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    public void testRedis() {
        String key = "testKey";
        String value = "Hello, Redis Cloud!";

        // Lưu giá trị vào Redis
        redisTemplate.opsForValue().set(key, value);

        // Đọc giá trị từ Redis
        String retrievedValue = (String) redisTemplate.opsForValue().get(key);

        System.out.println("Value from Redis: " + retrievedValue);
    }
}
