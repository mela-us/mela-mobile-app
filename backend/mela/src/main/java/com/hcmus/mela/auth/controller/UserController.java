package com.hcmus.mela.auth.controller;

import com.hcmus.mela.auth.dto.request.*;
import com.hcmus.mela.auth.dto.response.*;
import com.hcmus.mela.auth.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@AllArgsConstructor
public class UserController {

    private final UserService userService;

    @PostMapping("/login")
    @Operation(tags = "Login Service", description = "You must log in with the correct information to successfully obtain the token information.")
    public ResponseEntity<LoginResponse> loginRequest(@Valid @RequestBody LoginRequest loginRequest) {

        final LoginResponse loginResponse = userService.getLoginResponse(loginRequest);

        return ResponseEntity.ok(loginResponse);
    }

    @PostMapping("/register")
    @Operation(tags = "Register Service", description = "You can register to the system by sending information in the appropriate format.")
    public ResponseEntity<RegistrationResponse> registrationRequest(@Valid @RequestBody RegistrationRequest registrationRequest) {

        final RegistrationResponse registrationResponse = userService.registration(registrationRequest);

        return ResponseEntity.status(HttpStatus.CREATED).body(registrationResponse);
    }

    @GetMapping("/refresh-token")
    @Operation(
            tags = "Refresh Token Service",
            description = "API endpoint to refresh access token using the provided refresh token.")
    public ResponseEntity<RefreshTokenResponse> refreshToken(@Valid @RequestBody RefreshTokenRequest refreshTokenRequest) {

        final RefreshTokenResponse refreshTokenResponse = userService.getRefreshTokenResponse(refreshTokenRequest);

        return ResponseEntity.ok(refreshTokenResponse);
    }

    @RequestMapping(value = "/profile", method = RequestMethod.PUT)
    @Operation(
            tags = "Profile",
            description = "API endpoint to update user profile.")
    public ResponseEntity<UpdateProfileResponse> updateProfile(
            @RequestBody UpdateProfileRequest updateProfileRequest,
            @RequestHeader("Authorization") String authorizationHeader) {

        final UpdateProfileResponse updateProfileResponse = userService.updateProfile(updateProfileRequest, authorizationHeader);

        return ResponseEntity.status(HttpStatus.OK).body(updateProfileResponse);
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    @Operation(
            tags = "Profile",
            description = "API endpoint to get user profile.")
    public ResponseEntity<GetUserProfileResponse> getProfile(
            @RequestHeader("Authorization") String authorizationHeader) {

        final GetUserProfileResponse getUserProfileResponse = userService.getUserProfile(authorizationHeader);

        return ResponseEntity.status(HttpStatus.OK).body(getUserProfileResponse);
    }

    @RequestMapping(value = "/logout", method = RequestMethod.POST)
    @Operation(
            tags = "Logout",
            description = "API endpoint to logout.")
    public ResponseEntity<LogoutResponse> logout(@RequestBody LogoutRequest logoutRequest) {
        final LogoutResponse logoutResponse = userService.getLogoutResponse(logoutRequest);

        return ResponseEntity.status(HttpStatus.OK).body(logoutResponse);
    }
}
