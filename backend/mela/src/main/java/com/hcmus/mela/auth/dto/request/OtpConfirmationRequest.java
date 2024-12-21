package com.hcmus.mela.auth.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class OtpConfirmationRequest {
    @NotEmpty(message = "{forgot_password_username_not_empty}")
    @Email(message = "{forgot_password_username_must_be_email}")
    private String username;

    @NotEmpty(message = "{forgot_password_otp_not_empty}")
    private String otpCode;
}
