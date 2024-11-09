package com.hcmus.mela.security.service;

import com.hcmus.mela.model.User;
import com.hcmus.mela.security.dto.AuthenticatedUserDto;
import com.hcmus.mela.security.dto.RegistrationRequest;
import com.hcmus.mela.security.dto.RegistrationResponse;

public interface UserService {

	User findByUsername(String username);

	RegistrationResponse registration(RegistrationRequest registrationRequest);

	AuthenticatedUserDto findAuthenticatedUserByUsername(String username);
}
