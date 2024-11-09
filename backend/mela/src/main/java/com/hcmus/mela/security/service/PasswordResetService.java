package com.hcmus.mela.security.service;

import java.util.Optional;

import com.hcmus.mela.dto.request.ForgotPasswordRequest;
import com.hcmus.mela.dto.request.OtpConfirmationRequest;
import com.hcmus.mela.dto.request.ResetPasswordRequest;
import com.hcmus.mela.dto.response.OtpConfirmationResponse;
import com.hcmus.mela.dto.service.EmailDetails;
import com.hcmus.mela.security.jwt.JwtTokenForgetPasswordService;
import com.hcmus.mela.service.EmailService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hcmus.mela.model.User;
import com.hcmus.mela.repository.UserRepository;

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

    private final JwtTokenForgetPasswordService jwtTokenForgetPasswordService;

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
        return true;
    }

    public Optional<OtpConfirmationResponse> validateOtp(OtpConfirmationRequest otpConfirmationRequest) {
        if (otpService.validateOtpOfUser(otpConfirmationRequest.getOtp(), otpConfirmationRequest.getEmail())) {
            String token = jwtTokenForgetPasswordService.generateToken(otpConfirmationRequest.getEmail());
            OtpConfirmationResponse otpResponse = new OtpConfirmationResponse();
            otpResponse.setEmail(otpConfirmationRequest.getEmail());
            otpResponse.setJwt(token);
            return Optional.of(otpResponse);
        }
        return Optional.empty();
    }

    public void resetPassword(ResetPasswordRequest resetPasswordRequest) {
        if(jwtTokenForgetPasswordService.validateToken(resetPasswordRequest.getJwt(), resetPasswordRequest.getEmail())) {
            User user = userRepository.findByUsername(resetPasswordRequest.getEmail());
            user.setPassword(bCryptPasswordEncoder.encode(resetPasswordRequest.getNewPassword()));
            userRepository.save(user);
        }
    }
}
