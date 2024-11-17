package com.hcmus.mela.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@AllArgsConstructor
public class GetUserProfileResponse {
    private Long userId;

    private String fullName;

    private String username;

    private LocalDate birthday;

}
