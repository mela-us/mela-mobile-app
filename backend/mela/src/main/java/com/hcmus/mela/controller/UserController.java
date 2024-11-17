package com.hcmus.mela.controller;

import com.hcmus.mela.dto.request.UpdateProfileRequest;
import com.hcmus.mela.dto.response.GetUserProfileResponse;
import com.hcmus.mela.dto.response.UpdateProfileResponse;
import com.hcmus.mela.security.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@AllArgsConstructor
public class UserController {

    private final UserService userService;


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
}
