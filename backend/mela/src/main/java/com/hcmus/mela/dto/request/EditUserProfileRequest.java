package com.hcmus.mela.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class EditUserProfileRequest {

    private String fullName;

    private String imageUrl;

    private Date birthday;
}
