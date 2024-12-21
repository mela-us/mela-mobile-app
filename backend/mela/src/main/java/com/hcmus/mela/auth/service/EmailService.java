package com.hcmus.mela.auth.service;

import com.hcmus.mela.auth.dto.dto.EmailDetailsDto;
import jakarta.mail.MessagingException;

public interface EmailService {

    public String generateOtpNotify(String username, String otpCode);

    public void sendSimpleMail(EmailDetailsDto details);
}
