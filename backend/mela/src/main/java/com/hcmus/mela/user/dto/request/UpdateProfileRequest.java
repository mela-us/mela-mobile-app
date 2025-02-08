package com.hcmus.mela.user.dto.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
public class UpdateProfileRequest {

    private String fullname;

    private String imageUrl;

    @JsonFormat(pattern = "dd-MM-yyyy")
    private LocalDate birthday;
}
