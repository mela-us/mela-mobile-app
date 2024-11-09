package com.hcmus.mela.dto.request;

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
    @NotEmpty
    @Email
    private String email;

    @NotEmpty
    private String otp;
}
