package com.hcmus.mela.user.service;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.auth.service.OtpService;
import com.hcmus.mela.common.cache.RedisService;
import com.hcmus.mela.user.dto.request.*;
import com.hcmus.mela.user.dto.response.*;
import com.hcmus.mela.user.exception.exception.InvalidTokenException;
import com.hcmus.mela.user.exception.exception.EmptyUpdateDataException;
import com.hcmus.mela.user.mapper.UserMapper;
import com.hcmus.mela.user.model.User;
import com.hcmus.mela.user.repository.UserRepository;
import com.hcmus.mela.common.utils.ExceptionMessageAccessor;
import com.hcmus.mela.common.utils.GeneralMessageAccessor;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    private final OtpService otpService;

    private final RedisService redisService;

    private final JwtTokenService jwtTokenService;

    private final GeneralMessageAccessor generalMessageAccessor;

    private final ExceptionMessageAccessor exceptionMessageAccessor;

    @Override
    public UpdateProfileResponse updateProfile(UpdateProfileRequest updateProfileRequest, String authorizationHeader) {

        final UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);

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

        final UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);

        User user = userRepository.findById(userId).orElse(null);

        if (user == null) {
            final String userNotFound = exceptionMessageAccessor.getMessage(null, "user_not_found");
            throw new InvalidTokenException(userNotFound);
        }

        return UserMapper.INSTANCE.convertToGetUserProfileResponse(user);
    }

    @Transactional
    @Override
    public void deleteAccount(DeleteAccountRequest deleteAccountRequest, String authorizationHeader) {

            final UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);

            User user = userRepository.findById(userId).orElse(null);

            if (user == null) {
                final String userNotFound = exceptionMessageAccessor.getMessage(null, "user_not_found");
                throw new InvalidTokenException(userNotFound);
            }

            otpService.deleteOtpCodeByUserId(userId);

            userRepository.delete(user);

            redisService.storeAccessToken(deleteAccountRequest.getAccessToken());
            redisService.storeRefreshToken(deleteAccountRequest.getRefreshToken());
    }
}