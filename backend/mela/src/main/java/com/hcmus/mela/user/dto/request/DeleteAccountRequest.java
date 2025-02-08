package com.hcmus.mela.user.dto.request;

import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class DeleteAccountRequest {
    @NotEmpty(message = "Access token is required.")
    private String accessToken;

    @NotEmpty(message = "Refresh token is required.")
    private String refreshToken;
}
