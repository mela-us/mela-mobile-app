package com.hcmus.mela.service;

import java.time.LocalDateTime;

import com.hcmus.mela.security.dto.EmailDetails;
import com.hcmus.mela.security.dto.OtpConfirmationRequest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hcmus.mela.model.User;
import com.hcmus.mela.repository.UserOtpRepository;
import com.hcmus.mela.repository.UserRepository;
import com.hcmus.mela.security.dto.ForgotPasswordRequest;
import com.hcmus.mela.security.dto.ResetPasswordRequest;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class PasswordResetService {
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    private final UserRepository userRepository;

    private final OtpService otpService;

    private final EmailService emailService;

    public boolean generateOtpForResetPassword(ForgotPasswordRequest forgotPasswordRequest) {
        User user = userRepository.findByUsername(forgotPasswordRequest.getEmail());
        if (user == null) {
            return false; 
        }

        String otpCode = otpService.generateOtp();
        otpService.setOtpToUser(otpCode, user);

        EmailDetails details = new EmailDetails().builder()
                .recipient(user.getUsername())
                .subject("<b>Verify OTP</b>")
                .msgBody(otpCode + " is your otp code")
                .build();
        emailService.sendSimpleMail(details);
        System.out.println(otpCode);
        return true;
    }

    public boolean validateOtp(OtpConfirmationRequest otpConfirmationRequest) {
        return otpService.validateOtpOfUser(otpConfirmationRequest.getOtp(), otpConfirmationRequest.getEmail());
    }

    public void resetPassword(ResetPasswordRequest resetPasswordRequest) {
        User user = userRepository.findByUsername(resetPasswordRequest.getEmail());
        user.setPassword(bCryptPasswordEncoder.encode(resetPasswordRequest.getNewPassword()));
        userRepository.save(user);
    }
}
