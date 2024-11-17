package com.hcmus.mela.security.service;

import com.hcmus.mela.dto.request.LoginRequest;
import com.hcmus.mela.dto.request.RefreshTokenRequest;
import com.hcmus.mela.dto.request.RegistrationRequest;
import com.hcmus.mela.dto.request.UpdateProfileRequest;
import com.hcmus.mela.dto.response.*;
import com.hcmus.mela.model.postgre.User;

public interface UserService {

    User findByUsername(String username);

    RegistrationResponse registration(RegistrationRequest registrationRequest);

    void updatePassword(String username, String newPassword);

    UpdateProfileResponse updateProfile(UpdateProfileRequest updateProfileRequest, String authorizationHeader);

    GetUserProfileResponse getUserProfile(String authorizationHeader);

   RefreshTokenResponse getRefreshTokenResponse(RefreshTokenRequest refreshTokenRequest);

   LoginResponse getLoginResponse(LoginRequest loginRequest);
}
