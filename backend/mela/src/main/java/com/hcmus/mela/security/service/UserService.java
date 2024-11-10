package com.hcmus.mela.security.service;

import com.hcmus.mela.dto.request.RegistrationRequest;
import com.hcmus.mela.dto.response.RegistrationResponse;
import com.hcmus.mela.dto.service.AuthenticatedUserDto;
import com.hcmus.mela.model.User;

public interface UserService {

    User findByUsername(String username);

    RegistrationResponse registration(RegistrationRequest registrationRequest);

    AuthenticatedUserDto findAuthenticatedUserByUsername(String username);

    void updatePassword(String username, String newPassword);
}
