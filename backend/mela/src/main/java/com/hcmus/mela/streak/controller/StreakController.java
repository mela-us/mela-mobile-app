package com.hcmus.mela.streak.controller;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.streak.dto.response.GetStreakResponse;
import com.hcmus.mela.streak.dto.response.UpdateStreakResponse;
import com.hcmus.mela.streak.service.StreakService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@AllArgsConstructor
@Slf4j
@RequestMapping("/api/streak")
public class StreakController {

    private final StreakService streakService;

    private final JwtTokenService jwtTokenService;

    @GetMapping(value = "")
    @Operation(
            tags = "Streak Service",
            summary = "Get user's streak",
            description = "Retrieves a user's streak and the information belonging to the streak."
    )
    public ResponseEntity<GetStreakResponse> getStreak(@RequestHeader("Authorization") String authorizationHeader) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);

        log.info("Getting streak for user: {}", userId);

        final GetStreakResponse getStreakResponse = streakService.getStreak(userId);

        return ResponseEntity.ok(getStreakResponse);
    }

    @PostMapping(value = "")
    @Operation(
            tags = "Streak Service",
            summary = "Update user's streak",
            description = "Updates a user's streak."
    )
    public ResponseEntity<UpdateStreakResponse> updateStreak(@RequestHeader("Authorization") String authorizationHeader) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);

        log.info("Updating streak for user: {}", userId);

        final UpdateStreakResponse updateStreakResponse = streakService.updateStreak(userId);

        return ResponseEntity.ok(updateStreakResponse);
    }
}
