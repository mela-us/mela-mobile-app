package com.hcmus.mela.common.configuration;

import com.hcmus.mela.common.storage.AwsS3ServiceImpl;
import com.hcmus.mela.common.storage.StorageService;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.regions.Region;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.services.s3.presigner.S3Presigner;

@Configuration
public class AwsS3Configuration {

    @Value("${aws.s3.access-key}")
    private String ACCESS_KEY;

    @Value("${aws.s3.secret-key}")
    private String SECRET_KEY;

    @Value("${aws.s3.region}")
    private String REGION;

    @Bean
    public S3Client s3Client() {
        return S3Client.builder()
                .region(Region.of(REGION))
                .credentialsProvider(StaticCredentialsProvider.create(
                        AwsBasicCredentials.create(ACCESS_KEY, SECRET_KEY)))
                .build();
    }

    @Bean
    public S3Presigner s3Presigner() {
        return S3Presigner.builder()
                .region(Region.of(REGION))
                .credentialsProvider(StaticCredentialsProvider.create(
                        AwsBasicCredentials.create(ACCESS_KEY, SECRET_KEY)))
                .build();
    }

    @Bean
    @ConditionalOnProperty(name = "storage.provider", havingValue = "s3")
    public StorageService s3StorageService(S3Presigner presigner, @Value("${aws.s3.bucket-name}") String bucketName) {
        return new AwsS3ServiceImpl(presigner, bucketName);
    }
}
