package com.hcmus.mela.dto.response;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class OtpConfirmationResponse {
    private String username;
    private String token;
    private String message;
}
