package com.hcmus.mela.security.dto;

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
public class OtpConfirmationResponse {
    @Email
    @NotEmpty
    private String email;

    @NotEmpty
    private String jwt;
}
