package com.hcmus.mela;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories(basePackages = "com.hcmus.mela.repository.postgre")
public class MelaApplication {
    public static void main(String[] args) {
        SpringApplication.run(MelaApplication.class, args);
    }
}
