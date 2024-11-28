package com.hcmus.mela.auth.service;

import com.hcmus.mela.auth.dto.request.*;
import com.hcmus.mela.auth.dto.response.*;
import com.hcmus.mela.auth.exception.exception.InvalidTokenException;
import com.hcmus.mela.auth.exception.exception.RegistrationException;
import com.hcmus.mela.auth.model.User;
import com.hcmus.mela.auth.model.UserRole;
import com.hcmus.mela.auth.repository.UserRepository;
import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.auth.security.mapper.UserMapper;
import com.hcmus.mela.auth.security.utils.SecurityConstants;
import com.hcmus.mela.utils.ExceptionMessageAccessor;
import com.hcmus.mela.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.util.Strings;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private static final String REGISTRATION_SUCCESSFUL = "registration_successful";

    private static final String USERNAME_ALREADY_EXISTS = "username_already_exists";

    private final UserRepository userRepository;

    private final AuthenticationManager authenticationManager;

    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    private final GeneralMessageAccessor generalMessageAccessor;

    private final ExceptionMessageAccessor exceptionMessageAccessor;

    private final JwtTokenService jwtTokenService;

    private final TokenStoreService tokenStoreService;

    @Override
    public User findByUsername(String username) {

        return userRepository.findByUsername(username);
    }

    @Override
    public RegistrationResponse registration(RegistrationRequest registrationRequest) {

        final String username = registrationRequest.getUsername();

        final boolean existsByUsername = userRepository.existsByUsername(username);

        if (existsByUsername) {

            log.warn("{} is already being used!", username);

            final String existsUsername = exceptionMessageAccessor.getMessage(null, USERNAME_ALREADY_EXISTS);
            throw new RegistrationException(existsUsername);
        }

        final User user = UserMapper.INSTANCE.convertToUser(registrationRequest);
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setUserRole(UserRole.USER);
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(user.getCreatedAt());

        userRepository.save(user);

        final String registrationSuccessMessage = generalMessageAccessor.getMessage(null, REGISTRATION_SUCCESSFUL, username);

        log.info("{} registered successfully!", username);

        return new RegistrationResponse(registrationSuccessMessage);
    }

    @Override
    public void updatePassword(String username, String newPassword) {
        User user = this.findByUsername(username);
        if (user != null) {
            user.setPassword(bCryptPasswordEncoder.encode(newPassword));
            user.setUpdatedAt(LocalDateTime.now());
            userRepository.save(user);
        }
    }

    @Override
    public UpdateProfileResponse updateProfile(UpdateProfileRequest updateProfileRequest, String authorizationHeader) {

        final String accessToken = authorizationHeader.replace(SecurityConstants.TOKEN_PREFIX, Strings.EMPTY);

        final UUID userId = jwtTokenService.getUserIdFromToken(accessToken);

        // Check valid token
        final boolean validToken = jwtTokenService.validateToken(accessToken);

        if(!validToken) {
            final String invalidToken = exceptionMessageAccessor.getMessage(null, "invalid_token");
            throw new InvalidTokenException(invalidToken);
        }

        User user = userRepository.findById(userId).orElse(null);

        if (user == null) {
            final String userNotFound = exceptionMessageAccessor.getMessage(null, "user_not_found");
            throw new InvalidTokenException(userNotFound);
        }
        user.setBirthday(updateProfileRequest.getBirthday());
        user.setFullname(updateProfileRequest.getFullname());
        user.setImageUrl(updateProfileRequest.getImageUrl());
        user.setUpdatedAt(LocalDateTime.now());

        userRepository.save(user);

        final String updatedSuccessfully = generalMessageAccessor.getMessage(null, "update_user_successful");

        return new UpdateProfileResponse(updatedSuccessfully);
    }

    @Override
    public GetUserProfileResponse getUserProfile(String authorizationHeader) {

        final String accessToken = authorizationHeader.replace(SecurityConstants.TOKEN_PREFIX, Strings.EMPTY);

        final UUID userId = jwtTokenService.getUserIdFromToken(accessToken);

        User user = userRepository.findById(userId).orElse(null);

        if (user == null) {
            final String userNotFound = exceptionMessageAccessor.getMessage(null, "user_not_found");
            throw new InvalidTokenException(userNotFound);
        }

        return UserMapper.INSTANCE.convertToGetUserProfileResponse(user);
    }

    @Override
    public RefreshTokenResponse getRefreshTokenResponse(RefreshTokenRequest refreshTokenRequest) {

        final String refreshToken = refreshTokenRequest.getRefreshToken();

        // Check if the refresh token is blacklisted
        if (tokenStoreService.isRefreshTokenBlacklisted(refreshToken)) {
            final String blacklistedTokenMessage = exceptionMessageAccessor.getMessage(null, "blacklisted_refresh_token");
            throw new InvalidTokenException(blacklistedTokenMessage);
        }

        final boolean validToken = jwtTokenService.validateToken(refreshToken);

        final String username = jwtTokenService.getUsernameFromToken(refreshToken);

        final User user = userRepository.findByUsername(username);

        if (validToken) {
            return new RefreshTokenResponse(jwtTokenService.generateRefreshToken(user));
        } else {
            final String invalidToken = exceptionMessageAccessor.getMessage(null, "invalid_token");
            throw new InvalidTokenException(invalidToken);
        }
    }


    public LoginResponse getLoginResponse(LoginRequest loginRequest) {

        final String username = loginRequest.getUsername();
        final String password = loginRequest.getPassword();

        final UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(username, password);

        authenticationManager.authenticate(usernamePasswordAuthenticationToken);

        final User user = userRepository.findByUsername(username);

        final String accessToken = jwtTokenService.generateAccessToken(user);
        final String refreshToken = jwtTokenService.generateRefreshToken(user);

        return new LoginResponse(accessToken, refreshToken);
    }

    @Override
    public LogoutResponse getLogoutResponse(LogoutRequest logoutRequest) {

        tokenStoreService.storeAccessToken(logoutRequest.getAccessToken());
        tokenStoreService.storeRefreshToken(logoutRequest.getRefreshToken());

        final String logoutSuccessMessage = generalMessageAccessor.getMessage(null, "logout_successful");
        return new LogoutResponse(logoutSuccessMessage);
    }

}

