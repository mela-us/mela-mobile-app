package com.hcmus.mela.user.service;

import org.springframework.beans.factory.annotation.Value;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.presigner.S3Presigner;
import software.amazon.awssdk.services.s3.presigner.model.PresignedPutObjectRequest;

import java.time.Duration;

public class AwsS3ServiceImpl implements StorageService {

    private final S3Presigner presigner;
    private final String bucketName;

    private final String USER_IMAGE_FOLDER = "users/images/";

    public AwsS3ServiceImpl(S3Presigner presigner, @Value("${aws.s3.bucket-name}") String bucketName) {
        this.presigner = presigner;
        this.bucketName = bucketName;
    }

    @Override
    public String generatePreSignedUrl(String fileName) {
        PresignedPutObjectRequest presignedRequest = presigner.presignPutObject(r -> r
                .signatureDuration(Duration.ofMinutes(5))
                .putObjectRequest(PutObjectRequest.builder()
                        .bucket(bucketName)
                        .key(USER_IMAGE_FOLDER + fileName)
                        .build()));

        return presignedRequest.url().toString();
    }


    @Override
    public String getImageUrl(String fileName) {
        return "https://" + bucketName + ".s3.amazonaws.com/" + USER_IMAGE_FOLDER + fileName;
    }
}
