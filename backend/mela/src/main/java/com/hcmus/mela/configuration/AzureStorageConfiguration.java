package com.hcmus.mela.configuration;

import com.azure.storage.blob.BlobContainerClient;
import com.azure.storage.blob.BlobServiceClient;
import com.azure.storage.blob.BlobServiceClientBuilder;
import com.hcmus.mela.user.service.AzureServiceImpl;
import com.hcmus.mela.user.service.StorageService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AzureStorageConfiguration {

    @Value("${azure.storage.account-name}")
    private String ACCOUNT_NAME;

    @Value("${azure.storage.account-key}")
    private String ACCOUNT_KEY;

    @Value("${azure.storage.container-name}")
    private String CONTAINER_NAME;

    @Bean
    public BlobServiceClient blobServiceClient() {
        String connectionString = String.format("DefaultEndpointsProtocol=https;AccountName=%s;AccountKey=%s;EndpointSuffix=core.windows.net", ACCOUNT_NAME, ACCOUNT_KEY);
        return new BlobServiceClientBuilder().connectionString(connectionString).buildClient();
    }

    @Bean
    public BlobContainerClient blobContainerClient() {
        return blobServiceClient().getBlobContainerClient(CONTAINER_NAME);
    }

    @Bean
    @ConditionalOnProperty(name = "storage.provider", havingValue = "azure")
    public StorageService azureStorageService(BlobServiceClient blobServiceClient) {
        return new AzureServiceImpl(blobServiceClient);
    }
}
