package com.hcmus.mela.security.jwt;

import com.hcmus.mela.dto.request.LoginRequest;
import com.hcmus.mela.dto.request.RefreshTokenRequest;
import com.hcmus.mela.dto.response.LoginResponse;
import com.hcmus.mela.dto.response.RefreshTokenResponse;
import com.hcmus.mela.dto.service.AuthenticatedUserDto;
import com.hcmus.mela.exceptions.custom.RefreshTokenException;
import com.hcmus.mela.model.postgre.User;
import com.hcmus.mela.security.mapper.UserMapper;
import com.hcmus.mela.security.service.UserService;
import com.hcmus.mela.utils.ExceptionMessageAccessor;
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

    private final ExceptionMessageAccessor exceptionMessageAccessor;

    public LoginResponse getLoginResponse(LoginRequest loginRequest) {

        final String username = loginRequest.getUsername();
        final String password = loginRequest.getPassword();

        final UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(username, password);

        authenticationManager.authenticate(usernamePasswordAuthenticationToken);

        final AuthenticatedUserDto authenticatedUserDto = userService.findAuthenticatedUserByUsername(username);

        final User user = UserMapper.INSTANCE.convertToUser(authenticatedUserDto);
        final String accessToken = jwtTokenManager.generateAccessToken(user);
        final String refreshToken = jwtTokenManager.generateRefreshToken(user);
        final String message = "Log in successfully!";

        log.info("{} has successfully logged in!", user.getUsername());

        return new LoginResponse(accessToken, refreshToken, message);
    }

    public Long getUserIdFromToken(String token) {
        return jwtTokenManager.getUserIdFromToken(token);
    }

    public String getUsernameFromToken(String token) {
        return jwtTokenManager.getUsernameFromToken(token);
    }

    public RefreshTokenResponse getRefreshTokenResponse(RefreshTokenRequest refreshTokenRequest) {

        final String refreshToken = refreshTokenRequest.getRefreshToken();

        final String username = getUsernameFromToken(refreshToken);

        final AuthenticatedUserDto authenticatedUserDto = userService.findAuthenticatedUserByUsername(username);

        final User user = UserMapper.INSTANCE.convertToUser(authenticatedUserDto);

        final boolean validToken = jwtTokenManager.validateToken(refreshToken, user.getUsername());

        if (validToken) {
            return new RefreshTokenResponse(jwtTokenManager.generateRefreshToken(user));
        } else {
            final String invalidToken = exceptionMessageAccessor.getMessage(null, "{invalid_refresh_token}");
            throw new RefreshTokenException(invalidToken);
        }
    }
}
