package com.hcmus.mela.auth.service;

import com.hcmus.mela.auth.dto.request.ForgotPasswordRequest;
import com.hcmus.mela.auth.dto.request.OtpConfirmationRequest;
import com.hcmus.mela.auth.dto.request.ResetPasswordRequest;
import com.hcmus.mela.auth.dto.response.ForgotPasswordResponse;
import com.hcmus.mela.auth.dto.response.OtpConfirmationResponse;
import com.hcmus.mela.auth.dto.response.ResetPasswordResponse;
import com.hcmus.mela.auth.dto.dto.EmailDetailsDto;
import com.hcmus.mela.auth.exception.exception.ForgotPasswordException;
import com.hcmus.mela.auth.model.User;
import com.hcmus.mela.auth.repository.UserRepository;
import com.hcmus.mela.auth.security.jwt.JwtTokenForgotPasswordService;
import com.hcmus.mela.utils.ExceptionMessageAccessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class ForgotPasswordService {

    private static final String USER_NOT_FOUND = "username_not_found";

    private final ExceptionMessageAccessor exceptionMessageAccessor;

    private final UserServiceImpl userServiceImpl;

    private final UserRepository userRepository;

    private final OtpService otpService;

    private final EmailService emailService;

    private final JwtTokenForgotPasswordService jwtTokenForgotPasswordService;

    public ForgotPasswordResponse sendOtpCodeByEmail(ForgotPasswordRequest forgotPasswordRequest) {
        User user = userRepository.findByUsername(forgotPasswordRequest.getUsername());
        if (user == null) {
            throw new ForgotPasswordException(
                    "Sending otp via email failed! "
                    + exceptionMessageAccessor.getMessage(null, USER_NOT_FOUND, forgotPasswordRequest.getUsername())
            );
        }
        String otpCode = otpService.generateOtpCode(6);
        String otpMessage = emailService.generateOtpNotify(user.getUsername(), otpCode);
        new EmailDetailsDto();
        EmailDetailsDto details = EmailDetailsDto.builder()
                .recipient(user.getUsername())
                .subject("Verify OTP - Forget Password")
                .msgBody(otpMessage)
                .build();

        otpService.cacheOtpCode(otpCode, user);
        emailService.sendSimpleMail(details);
        return new ForgotPasswordResponse("Send otp code to email successfully!");
    }

    public OtpConfirmationResponse validateOtp(OtpConfirmationRequest otpConfirmationRequest) {
        if (otpService.validateOtpOfUser(otpConfirmationRequest.getOtpCode(), otpConfirmationRequest.getUsername())) {
            String token = jwtTokenForgotPasswordService.generateToken(otpConfirmationRequest.getUsername());
            OtpConfirmationResponse otpConfirmationResponse = new OtpConfirmationResponse();
            otpConfirmationResponse.setUsername(otpConfirmationRequest.getUsername());
            otpConfirmationResponse.setToken(token);
            otpConfirmationResponse.setMessage("Otp validation is successful!");
            return otpConfirmationResponse;
        }
        throw new ForgotPasswordException("Otp validation failed!");
    }

    public ResetPasswordResponse resetPassword(ResetPasswordRequest resetPasswordRequest) {
        if (jwtTokenForgotPasswordService.validateToken(resetPasswordRequest.getToken(), resetPasswordRequest.getUsername())) {
            userServiceImpl.updatePassword(resetPasswordRequest.getUsername(), resetPasswordRequest.getNewPassword());
            return new ResetPasswordResponse("Reset password successfully!");
        }
        throw new ForgotPasswordException("Reset password failed!");
    }
}
