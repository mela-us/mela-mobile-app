package com.hcmus.mela.history.controller;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.history.dto.request.ExerciseResultRequest;
import com.hcmus.mela.history.dto.response.ExerciseResultResponse;
import com.hcmus.mela.history.service.ExerciseHistoryService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/api/exercise-histories")
public class ExerciseHistoryController {

    private final ExerciseHistoryService exerciseHistoryService;

    private final JwtTokenService jwtTokenService;

    @PostMapping
    @Operation(
            tags = "History Service",
            summary = "Save exercise result",
            description = "Save exercise result of the user in the system."
    )
    public ResponseEntity<ExerciseResultResponse> saveExerciseHistory(
            @RequestHeader("Authorization") String authorizationHeader,
            @RequestBody ExerciseResultRequest exerciseResultRequest) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);

        log.info("Saving exercise result for user: {}", userId);
        ExerciseResultResponse response = exerciseHistoryService.getExerciseResultResponse(userId, exerciseResultRequest);

        return ResponseEntity.ok(response);
    }
}
