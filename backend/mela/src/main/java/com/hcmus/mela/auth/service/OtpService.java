package com.hcmus.mela.auth.service;

import com.hcmus.mela.auth.model.User;

import java.util.UUID;

public interface OtpService {

    String generateOtpCode(int length);

    void cacheOtpCode(String otpCode, User user);

    boolean validateOtpOfUser(String otpCode, UUID userId);

    void deleteOtpCodeByUserId(UUID userId);
}
