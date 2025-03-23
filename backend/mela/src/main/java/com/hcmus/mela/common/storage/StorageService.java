package com.hcmus.mela.common.storage;

public interface StorageService {
    String generatePreSignedUrl(String fileName);
    String getImageUrl(String fileName);
}
