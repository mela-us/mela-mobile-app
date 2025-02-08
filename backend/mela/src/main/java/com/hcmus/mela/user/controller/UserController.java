package com.hcmus.mela.user.controller;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.user.dto.request.*;
import com.hcmus.mela.user.dto.response.*;
import com.hcmus.mela.user.service.StorageService;
import com.hcmus.mela.user.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api")
@AllArgsConstructor
public class UserController {

    private final UserService userService;

    private final StorageService storageService;

    private final JwtTokenService jwtTokenService;

    @RequestMapping(value = "/users/profile/upload-image-url", method = RequestMethod.GET)
    @Operation(
            tags = "User Service",
            description = "API endpoint to get pre-signed URL for uploading user profile image.")
    public ResponseEntity<Map<String, String>> getUploadUrl(
            @RequestHeader("Authorization") String authorizationHeader) {

        // Extract user id from JWT token
        // File name will be user id
        UUID userId = jwtTokenService.getUserIdFromToken(
                jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader)
        );

        // Generate pre-signed URL for uploading user profile image
        final String preSignedUrl = storageService.generatePreSignedUrl(userId.toString());

        // Get image URL
        final String imageUrl = storageService.getImageUrl(userId.toString());

        return ResponseEntity.status(HttpStatus.OK).body(
                Map.of("preSignedUrl", preSignedUrl, "imageUrl", imageUrl)
        );
    }

    @RequestMapping(value = "/users/profile", method = RequestMethod.PUT)
    @Operation(
            tags = "User Service",
            description = "API endpoint to update user profile.")
    public ResponseEntity<UpdateProfileResponse> updateProfile(
            @RequestBody @Valid UpdateProfileRequest updateProfileRequest,
            @RequestHeader("Authorization") String authorizationHeader) {

        final UpdateProfileResponse updateProfileResponse = userService.updateProfile(updateProfileRequest, authorizationHeader);

        return ResponseEntity.status(HttpStatus.OK).body(updateProfileResponse);
    }

    @RequestMapping(value = "/users/profile", method = RequestMethod.GET)
    @Operation(
            tags = "User Service",
            description = "API endpoint to get user profile.")
    public ResponseEntity<GetUserProfileResponse> getProfile(
            @RequestHeader("Authorization") String authorizationHeader) {

        final GetUserProfileResponse getUserProfileResponse = userService.getUserProfile(authorizationHeader);

        return ResponseEntity.status(HttpStatus.OK).body(getUserProfileResponse);
    }

    @RequestMapping(value = "/users/account", method = RequestMethod.DELETE)
    @Operation(
            tags = "User Service",
            description = "API endpoint to delete user account.")
    public ResponseEntity<Void> deleteAccount(
            @RequestHeader("Authorization") String authorizationHeader) {

        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }


}
