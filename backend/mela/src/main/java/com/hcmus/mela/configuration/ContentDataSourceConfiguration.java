package com.hcmus.mela.configuration;

import com.hcmus.mela.utils.ProjectConstants;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.config.AbstractMongoClientConfiguration;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;
import org.springframework.lang.NonNull;

@Configuration
@EnableMongoRepositories(basePackages =
        {
                "com.hcmus.mela.exercise.repository",
                "com.hcmus.mela.lecture.repository",
                "com.hcmus.mela.statistic.repository"
        }
    )
@RequiredArgsConstructor
public class ContentDataSourceConfiguration extends AbstractMongoClientConfiguration {

    @Value("${spring.data.mongodb.uri}")
    private String mongoUri;

    @Override
    @NonNull
    protected String getDatabaseName() {
        return ProjectConstants.CONTENT_DATABASE_NAME;
    }

    @Bean
    @Override
    @NonNull
    public MongoClient mongoClient() {
        return MongoClients.create(mongoUri);
    }

    @Bean
    @NonNull
    public MongoTemplate mongoTemplate(MongoClient mongoClient) {
        return new MongoTemplate(mongoClient, getDatabaseName());
    }
}
