package com.hcmus.mela.auth.controller;

import com.hcmus.mela.auth.dto.request.*;
import com.hcmus.mela.auth.dto.response.*;
import com.hcmus.mela.auth.service.AuthService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@AllArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/login")
    @Operation(tags = "Auth", description = "You must log in with the correct information to successfully obtain the token information.")
    public ResponseEntity<LoginResponse> loginRequest(@Valid @RequestBody LoginRequest loginRequest) {

        final LoginResponse loginResponse = authService.getLoginResponse(loginRequest);

        return ResponseEntity.ok(loginResponse);
    }

    @PostMapping("/register")
    @Operation(tags = "Auth", description = "You can register to the system by sending information in the appropriate format.")
    public ResponseEntity<RegistrationResponse> registrationRequest(@Valid @RequestBody RegistrationRequest registrationRequest) {

        final RegistrationResponse registrationResponse = authService.registration(registrationRequest);

        return ResponseEntity.status(HttpStatus.CREATED).body(registrationResponse);
    }

    @PostMapping("/refresh-token")
    @Operation(
            tags = "Auth",
            description = "API endpoint to refresh access token using the provided refresh token.")
    public ResponseEntity<RefreshTokenResponse> refreshToken(@Valid @RequestBody RefreshTokenRequest refreshTokenRequest) {

        final RefreshTokenResponse refreshTokenResponse = authService.getRefreshTokenResponse(refreshTokenRequest);

        return ResponseEntity.ok(refreshTokenResponse);
    }

    @RequestMapping(value = "/logout", method = RequestMethod.POST)
    @Operation(
            tags = "Auth Service",
            description = "API endpoint to logout.")
    public ResponseEntity<LogoutResponse> logout(@RequestBody LogoutRequest logoutRequest) {
        final LogoutResponse logoutResponse = authService.getLogoutResponse(logoutRequest);

        return ResponseEntity.status(HttpStatus.OK).body(logoutResponse);
    }
}
