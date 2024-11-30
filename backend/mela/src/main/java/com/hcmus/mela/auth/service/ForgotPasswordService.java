package com.hcmus.mela.auth.service;

import com.hcmus.mela.auth.dto.request.ForgotPasswordRequest;
import com.hcmus.mela.auth.dto.request.OtpConfirmationRequest;
import com.hcmus.mela.auth.dto.request.ResetPasswordRequest;
import com.hcmus.mela.auth.dto.response.ForgotPasswordResponse;
import com.hcmus.mela.auth.dto.response.OtpConfirmationResponse;
import com.hcmus.mela.auth.dto.response.ResetPasswordResponse;

public interface ForgotPasswordService {

    public ForgotPasswordResponse sendOtpCodeByEmail(ForgotPasswordRequest forgotPasswordRequest);

    public OtpConfirmationResponse validateOtp(OtpConfirmationRequest otpConfirmationRequest);

    public ResetPasswordResponse resetPassword(ResetPasswordRequest resetPasswordRequest);
}
