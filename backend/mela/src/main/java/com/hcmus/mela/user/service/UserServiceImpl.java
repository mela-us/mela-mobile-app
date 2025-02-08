package com.hcmus.mela.user.service;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.auth.security.utils.SecurityConstants;
import com.hcmus.mela.user.dto.request.*;
import com.hcmus.mela.user.dto.response.*;
import com.hcmus.mela.user.exception.exception.InvalidTokenException;
import com.hcmus.mela.user.exception.exception.EmptyUpdateDataException;
import com.hcmus.mela.user.mapper.UserMapper;
import com.hcmus.mela.user.model.User;
import com.hcmus.mela.user.repository.UserRepository;
import com.hcmus.mela.utils.ExceptionMessageAccessor;
import com.hcmus.mela.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.util.Strings;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    private final JwtTokenService jwtTokenService;

    private final GeneralMessageAccessor generalMessageAccessor;

    private final ExceptionMessageAccessor exceptionMessageAccessor;

    @Override
    public UpdateProfileResponse updateProfile(UpdateProfileRequest updateProfileRequest, String authorizationHeader) {

        final String accessToken = authorizationHeader.replace(SecurityConstants.TOKEN_PREFIX, Strings.EMPTY);

        final UUID userId = jwtTokenService.getUserIdFromToken(accessToken);

        // Check valid token
        final boolean validToken = jwtTokenService.validateToken(accessToken);

        if (!validToken) {
            final String invalidToken = exceptionMessageAccessor.getMessage(null, "invalid_token");
            throw new InvalidTokenException(invalidToken);
        }

        User user = userRepository.findById(userId).orElse(null);

        if (user == null) {
            final String userNotFound = exceptionMessageAccessor.getMessage(null, "user_not_found");
            throw new InvalidTokenException(userNotFound);
        }

        if (updateProfileRequest.getBirthday() == null &&
                updateProfileRequest.getFullname() == null &&
                updateProfileRequest.getImageUrl() == null) {
            final String noDataToUpdate = exceptionMessageAccessor.getMessage(null, "no_data_to_update");
            throw new EmptyUpdateDataException(noDataToUpdate);
        }

        if (updateProfileRequest.getBirthday() != null) {
            user.setBirthday(updateProfileRequest.getBirthday());
        }

        if (updateProfileRequest.getFullname() != null) {
            user.setFullname(updateProfileRequest.getFullname());
        }

        if (updateProfileRequest.getImageUrl() != null) {
            user.setImageUrl(updateProfileRequest.getImageUrl());
        }

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
}