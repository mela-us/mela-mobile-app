package com.hcmus.mela.auth.service;

import com.hcmus.mela.auth.model.User;

public interface OtpService {

    public String generateOtpCode(int length);

    public void cacheOtpCode(String otpCode, User user);

    public boolean validateOtpOfUser(String otpCode, String username);
}
