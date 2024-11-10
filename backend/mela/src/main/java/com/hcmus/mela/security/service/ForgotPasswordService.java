package com.hcmus.mela.security.service;

import com.hcmus.mela.dto.request.ForgotPasswordRequest;
import com.hcmus.mela.dto.request.OtpConfirmationRequest;
import com.hcmus.mela.dto.request.ResetPasswordRequest;
import com.hcmus.mela.dto.response.ForgotPasswordResponse;
import com.hcmus.mela.dto.response.OtpConfirmationResponse;
import com.hcmus.mela.dto.response.ResetPasswordResponse;
import com.hcmus.mela.dto.service.EmailDetails;
import com.hcmus.mela.exceptions.custom.ForgotPasswordException;
import com.hcmus.mela.security.jwt.JwtTokenForgotPasswordService;
import com.hcmus.mela.service.EmailService;
import com.hcmus.mela.utils.ExceptionMessageAccessor;
import org.springframework.stereotype.Service;
import com.hcmus.mela.model.User;
import com.hcmus.mela.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

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
                    exceptionMessageAccessor.getMessage(null, USER_NOT_FOUND, forgotPasswordRequest.getUsername())
            );
        }
        String otpCode = otpService.generateOtpCode(6);
        String otpMessage = emailService.generateOtpNotify(user.getUsername(), otpCode);
        EmailDetails details = new EmailDetails().builder()
                .recipient(user.getUsername())
                .subject("Verify OTP - Forget Password")
                .msgBody(otpMessage)
                .build();

        otpService.cacheOtpCode(otpCode, user);
        emailService.sendSimpleMail(details);
        return new ForgotPasswordResponse("Send otp code to email successfully!");
    }

    public  OtpConfirmationResponse validateOtp(OtpConfirmationRequest otpConfirmationRequest) {
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
        if(jwtTokenForgotPasswordService.validateToken(resetPasswordRequest.getToken(), resetPasswordRequest.getUsername())) {
            userServiceImpl.updatePassword(resetPasswordRequest.getUsername(), resetPasswordRequest.getNewPassword());
            return new ResetPasswordResponse("Reset password successfully!");
        }
        throw new ForgotPasswordException("Reset password failed!");
    }
}
