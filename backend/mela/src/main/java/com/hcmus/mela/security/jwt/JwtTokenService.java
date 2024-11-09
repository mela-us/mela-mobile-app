package com.hcmus.mela.security.jwt;

import com.hcmus.mela.model.User;
import com.hcmus.mela.dto.service.AuthenticatedUserDto;
import com.hcmus.mela.dto.request.LoginRequest;
import com.hcmus.mela.dto.response.LoginResponse;
import com.hcmus.mela.security.mapper.UserMapper;
import com.hcmus.mela.security.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class JwtTokenService {

	private final UserService userService;

	private final JwtTokenManager jwtTokenManager;

	private final AuthenticationManager authenticationManager;

	public LoginResponse getLoginResponse(LoginRequest loginRequest) {

		final String username = loginRequest.getUsername();
		final String password = loginRequest.getPassword();

		final UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(username, password);

		authenticationManager.authenticate(usernamePasswordAuthenticationToken);

		final AuthenticatedUserDto authenticatedUserDto = userService.findAuthenticatedUserByUsername(username);

		final User user = UserMapper.INSTANCE.convertToUser(authenticatedUserDto);
		final String token = jwtTokenManager.generateToken(user);
		final String message = "Log in successfully!";

		log.info("{} has successfully logged in!", user.getUsername());

		return new LoginResponse(token, message);
	}

}
