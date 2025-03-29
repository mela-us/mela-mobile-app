package com.hcmus.mela.history.controller;

import com.hcmus.mela.history.dto.request.ExerciseResultRequest;
import com.hcmus.mela.history.dto.response.ExerciseResultResponse;
import com.hcmus.mela.history.service.ExerciseHistoryService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/exercise-histories")
public class ExerciseHistoryController {

    private final ExerciseHistoryService exerciseHistoryService;

    @PostMapping
    @Operation(tags = "History Service", description = "Get and save exercise result.")
    public ResponseEntity<ExerciseResultResponse> saveExerciseHistory(
            @RequestHeader("Authorization") String authorizationHeader,
            @RequestBody ExerciseResultRequest exerciseResultRequest) {
        ExerciseResultResponse response = exerciseHistoryService.getExerciseResultResponse(authorizationHeader, exerciseResultRequest);
        return ResponseEntity.ok(response);
    }
}
