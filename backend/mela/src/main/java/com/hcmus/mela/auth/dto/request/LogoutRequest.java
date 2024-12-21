package com.hcmus.mela.auth.dto.request;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class LogoutRequest {

    @NotEmpty(message = "{access_token_not_empty}")
    @NotNull(message = "{access_token_not_empty}")
    private String accessToken;

    @NotEmpty(message = "{refresh_token_not_empty}")
    @NotNull(message = "{refresh_token_not_empty}")
    private String refreshToken;
}
