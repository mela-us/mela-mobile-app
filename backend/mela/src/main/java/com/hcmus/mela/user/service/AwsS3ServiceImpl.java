package com.hcmus.mela.user.service;

import org.springframework.beans.factory.annotation.Value;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.presigner.S3Presigner;
import software.amazon.awssdk.services.s3.presigner.model.PresignedGetObjectRequest;

import java.net.URL;
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
        PresignedGetObjectRequest presignedRequest = presigner.presignGetObject(r -> r
                .signatureDuration(Duration.ofMinutes(5))
                .getObjectRequest(GetObjectRequest.builder()
                        .bucket(bucketName)
                        .key(USER_IMAGE_FOLDER + fileName + ".jpg")
                        .build()));

        URL url = presignedRequest.url();
        return url.toString();
    }

    @Override
    public String getImageUrl(String fileName) {
        return "https://" + bucketName + ".s3.amazonaws.com/" + USER_IMAGE_FOLDER + fileName + ".jpg";
    }
}
