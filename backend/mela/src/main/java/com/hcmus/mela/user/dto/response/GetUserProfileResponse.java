package com.hcmus.mela.user.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.Date;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
public class GetUserProfileResponse {
    private UUID userId;

    private String fullname;

    private String username;

    private Date birthday;

    private String imageUrl;
}
