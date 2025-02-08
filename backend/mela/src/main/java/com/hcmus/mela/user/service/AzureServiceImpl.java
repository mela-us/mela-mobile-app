package com.hcmus.mela.user.service;

import com.azure.storage.blob.BlobClient;
import com.azure.storage.blob.BlobServiceClient;
import com.azure.storage.blob.sas.BlobSasPermission;
import com.azure.storage.blob.sas.BlobServiceSasSignatureValues;
import lombok.RequiredArgsConstructor;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.time.OffsetDateTime;

@RequiredArgsConstructor
public class AzureServiceImpl implements StorageService {

    private final BlobServiceClient blobServiceClient;

    private static final String USER_CONTAINER = "users";
    private static final String USER_IMAGE_FOLDER = "images";
    private static final String EXTENSION = ".jpg";

    public BlobClient getBlobClient(String fileName) {
        return blobServiceClient.getBlobContainerClient(USER_CONTAINER)
                .getBlobClient(USER_IMAGE_FOLDER + "/" + fileName + EXTENSION);
    }

    public String getBlobUrl(String fileName) {
        return getBlobClient(fileName).getBlobUrl();
    }

    @Override
    public String generatePreSignedUrl(String fileName) {
        BlobSasPermission permissions = new BlobSasPermission()
                .setReadPermission(true)
                .setWritePermission(true)
                .setDeletePermission(true);

        OffsetDateTime expiryTime = OffsetDateTime.now().plusMinutes(5);

        BlobServiceSasSignatureValues sasValues = new BlobServiceSasSignatureValues(expiryTime, permissions);
        String sasToken = getBlobClient(fileName).generateSas(sasValues);

        return getBlobUrl(fileName) + "?" + sasToken;
    }

    @Override
    public String getImageUrl(String fileName) {
        return URLDecoder.decode(getBlobUrl(fileName), StandardCharsets.UTF_8);
    }
}