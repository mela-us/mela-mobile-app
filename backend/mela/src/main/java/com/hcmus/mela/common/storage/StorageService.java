package com.hcmus.mela.common.storage;

import java.util.Map;

public interface StorageService {

    Map<String, String> getUploadUserImagePreSignedUrl(String fileName);

    Map<String, String> getUploadConversationFilePreSignedUrl(String fileName);
}
