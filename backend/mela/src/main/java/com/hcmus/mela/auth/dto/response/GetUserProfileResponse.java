package com.hcmus.mela.auth.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
public class GetUserProfileResponse {
    private UUID userId;

    private String fullname;

    private String username;

    private LocalDate birthday;

}
