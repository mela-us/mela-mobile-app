package com.hcmus.mela.user.service;

public interface StorageService {
    String generatePreSignedUrl(String fileName);
    String getImageUrl(String fileName);
}
