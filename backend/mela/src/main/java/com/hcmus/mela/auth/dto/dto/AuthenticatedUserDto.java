package com.hcmus.mela.auth.dto.dto;


import com.hcmus.mela.auth.model.UserRole;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor
public class AuthenticatedUserDto {

    private Long userId;

    private String name;

    private String username;

    private String password;

    private UserRole userRole;

}
