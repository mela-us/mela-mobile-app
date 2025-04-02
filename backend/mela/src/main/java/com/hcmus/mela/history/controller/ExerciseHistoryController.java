package com.hcmus.mela.history.controller;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.history.dto.request.ExerciseResultRequest;
import com.hcmus.mela.history.dto.response.ExerciseResultResponse;
import com.hcmus.mela.history.service.ExerciseHistoryService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/exercise-histories")
public class ExerciseHistoryController {

    private final ExerciseHistoryService exerciseHistoryService;

    private final JwtTokenService jwtTokenService;

    @PostMapping
    @Operation(tags = "History Service", description = "Save exercise result.")
    public ResponseEntity<ExerciseResultResponse> saveExerciseHistory(
            @RequestHeader("Authorization") String authorizationHeader,
            @RequestBody ExerciseResultRequest exerciseResultRequest) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);
        ExerciseResultResponse response = exerciseHistoryService.getExerciseResultResponse(userId, exerciseResultRequest);
        return ResponseEntity.ok(response);
    }
}
