package com.hcmus.mela.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.hcmus.mela.security.dto.ForgotPasswordRequest;

import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PathVariable;

import com.hcmus.mela.service.PasswordResetService;

import org.springframework.web.bind.annotation.RequestBody;

import com.hcmus.mela.security.dto.OtpConfirmationRequest;
import com.hcmus.mela.security.dto.ResetPasswordRequest;



@RestController
@RequiredArgsConstructor
@RequestMapping("/forgot-password")
public class ResetPasswordController {
    private final PasswordResetService passwordResetService;

    @PostMapping("/{email}")
    @ResponseStatus(HttpStatus.OK)
    @Operation(tags = "Forgot Password Service", 
        description = "You can use your email to change password. You will receive otp via email if your email is valid.")
    public void forgotPasswordRequest (@PathVariable ForgotPasswordRequest forgotPwRequest) {
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
