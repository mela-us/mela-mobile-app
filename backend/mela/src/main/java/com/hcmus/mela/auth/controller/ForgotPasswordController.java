package com.hcmus.mela.auth.controller;

import com.hcmus.mela.auth.dto.request.ForgotPasswordRequest;
import com.hcmus.mela.auth.dto.request.OtpConfirmationRequest;
import com.hcmus.mela.auth.dto.request.ResetPasswordRequest;
import com.hcmus.mela.auth.dto.response.ForgotPasswordResponse;
import com.hcmus.mela.auth.dto.response.OtpConfirmationResponse;
import com.hcmus.mela.auth.dto.response.ResetPasswordResponse;
import com.hcmus.mela.auth.service.ForgotPasswordService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/forgot-password")
public class ForgotPasswordController {

    private final ForgotPasswordService forgotPasswordService;

    @PostMapping
    @Operation(tags = "Forgot Password Service", description = "You can enter your email to receive otp via the email.")
    public ResponseEntity<ForgotPasswordResponse> forgotPasswordRequest(@Valid @RequestBody ForgotPasswordRequest forgotPasswordRequest) {

        final ForgotPasswordResponse forgotPasswordResponse = forgotPasswordService.sendOtpCodeByEmail(forgotPasswordRequest);

        return ResponseEntity.status(HttpStatus.OK).body(forgotPasswordResponse);
    }

    @PostMapping("/validate-otp")
    @Operation(tags = "Forgot Password Service", description = "You must provide otp code to verify your account.")
    public ResponseEntity<OtpConfirmationResponse> validateOtpRequest(@Valid @RequestBody OtpConfirmationRequest otpConfirmationRequest) {

        final OtpConfirmationResponse otpConfirmationResponse = forgotPasswordService.validateOtp(otpConfirmationRequest);

        return ResponseEntity.status(HttpStatus.OK).body(otpConfirmationResponse);
    }

    @PostMapping("/reset-password")
    @Operation(tags = "Forgot Password Service", description = "You can reset your password.")
    public ResponseEntity<ResetPasswordResponse> resetPasswordRequest(@Valid @RequestBody ResetPasswordRequest resetPasswordRequest) {

        final ResetPasswordResponse resetPasswordResponse = forgotPasswordService.resetPassword(resetPasswordRequest);

        return ResponseEntity.status(HttpStatus.OK).body(resetPasswordResponse);
    }
}
