package com.hcmus.mela.controller;

import io.swagger.v3.oas.annotations.Parameter;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.hcmus.mela.security.dto.ForgotPasswordRequest;

import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;

import com.hcmus.mela.service.PasswordResetService;

import com.hcmus.mela.security.dto.OtpConfirmationRequest;
import com.hcmus.mela.security.dto.ResetPasswordRequest;

@RestController
@RequiredArgsConstructor
@RequestMapping("/forgot-password")
public class ResetPasswordController {
    private final PasswordResetService passwordResetService;

    @PostMapping("/test")
    @ResponseStatus(HttpStatus.OK)
    public String test(@RequestBody ForgotPasswordRequest forgotPwRequest) {
        return forgotPwRequest.getEmail();
    }

    @PostMapping()
    @ResponseStatus(HttpStatus.OK)
    @Operation(tags = "Forgot Password Service", 
        description = "You can use your email to change password. You will receive otp via email if your email is valid.")
    public void forgotPasswordRequest (@RequestBody ForgotPasswordRequest forgotPwRequest) {
        passwordResetService.generateOtpForResetPassword(forgotPwRequest);
    }
    
    @PostMapping("/validate-otp")
    @Operation(tags = "Otp Service", description = "You can enter the otp you receive via email.")
    public ResponseEntity<?> validateOtpRequest(@RequestBody OtpConfirmationRequest otpConfirmationRequest) {
        if (passwordResetService.validateOtp(otpConfirmationRequest)) {
            return new ResponseEntity<>("sucess", HttpStatus.OK);
        }
        return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
    }

    @PostMapping("/reset-password")
    @Operation(tags = "Reset Password Service", description = "You can reset your password.")
    public void changePasswordRequest (@RequestBody ResetPasswordRequest resetPasswordRequest) {
       passwordResetService.resetPassword(resetPasswordRequest);
    }
}
