package com.hcmus.mela.auth.service;

import com.hcmus.mela.auth.dto.request.*;
import com.hcmus.mela.auth.dto.response.*;
import com.hcmus.mela.auth.model.User;

public interface AuthService {

    User findByUsername(String username);

    RegistrationResponse registration(RegistrationRequest registrationRequest);

    void updatePassword(String username, String newPassword);

   RefreshTokenResponse getRefreshTokenResponse(RefreshTokenRequest refreshTokenRequest);

   LoginResponse getLoginResponse(LoginRequest loginRequest);

   LogoutResponse getLogoutResponse(LogoutRequest logoutRequest);
}
