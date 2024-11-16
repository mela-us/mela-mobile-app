package com.hcmus.mela.controller;

import com.hcmus.mela.dto.request.RefreshTokenRequest;
import com.hcmus.mela.dto.response.RefreshTokenResponse;
import com.hcmus.mela.security.jwt.JwtTokenService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/refresh-token")
public class RefreshTokenController {
    private final JwtTokenService jwtTokenService;

    @GetMapping
    @Operation(
            tags = "Refresh Token Service",
            description = "API endpoint to refresh access token using the provided refresh token.")
    public ResponseEntity<RefreshTokenResponse> refreshToken(@Valid @RequestBody RefreshTokenRequest refreshTokenRequest) {

        final RefreshTokenResponse refreshTokenResponse = jwtTokenService.getRefreshTokenResponse(refreshTokenRequest);

        return ResponseEntity.ok(refreshTokenResponse);
    }
}
