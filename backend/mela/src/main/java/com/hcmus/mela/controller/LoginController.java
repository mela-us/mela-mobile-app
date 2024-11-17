package com.hcmus.mela.controller;

import com.hcmus.mela.dto.request.LoginRequest;
import com.hcmus.mela.dto.response.LoginResponse;
import com.hcmus.mela.security.jwt.JwtTokenService;
import com.hcmus.mela.security.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/login")
public class LoginController {

    private final UserService userService;

    @PostMapping
    @Operation(tags = "Login Service", description = "You must log in with the correct information to successfully obtain the token information.")
    public ResponseEntity<LoginResponse> loginRequest(@Valid @RequestBody LoginRequest loginRequest) {

        final LoginResponse loginResponse = userService.getLoginResponse(loginRequest);

        return ResponseEntity.ok(loginResponse);
    }

}
