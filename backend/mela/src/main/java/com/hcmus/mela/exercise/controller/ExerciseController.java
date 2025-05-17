package com.hcmus.mela.exercise.controller;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.exercise.dto.request.ExerciseRequest;
import com.hcmus.mela.exercise.dto.response.ExerciseResponse;
import com.hcmus.mela.exercise.dto.response.QuestionResponse;
import com.hcmus.mela.exercise.service.ExerciseService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@AllArgsConstructor
@Slf4j
@RequestMapping("/api")
public class ExerciseController {

    private final ExerciseService exerciseService;

    private final JwtTokenService jwtTokenService;

    @GetMapping(value = "/lectures/{lectureId}/exercises")
    @Operation(
            tags = "Exercise Service",
            summary = "Get sections",
            description = "Retrieves a list of exercises belonging to a lecture from the system."
    )
    public ResponseEntity<ExerciseResponse> getExerciseInLecture(
            @Parameter(description = "Lecture id", example = "54c3abc5-3e8b-4017-acc2-c1005cd51c28")
            @PathVariable String lectureId,
            @RequestHeader("Authorization") String authorizationHeader) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);
        ExerciseRequest exerciseRequest = new ExerciseRequest(null, UUID.fromString(lectureId), userId);

        log.info("Getting exercises for lecture: {}", lectureId);
        final ExerciseResponse exerciseResponse = exerciseService.getAllExercisesInLecture(exerciseRequest);

        return ResponseEntity.ok(exerciseResponse);
    }

    @GetMapping(value = "/exercises/{exerciseId}")
    @Operation(
            tags = "Exercise Service",
            summary = "Get questions",
            description = "Retrieves a list of questions belonging to an exercise from the system."
    )
    public ResponseEntity<QuestionResponse> getExercise(
            @Parameter(description = "Exercise id", example = "b705289f-888d-44be-a894-c7d0db1cec67")
            @PathVariable String exerciseId,
            @RequestHeader("Authorization") String authorizationHeader) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);
        ExerciseRequest exerciseRequest = new ExerciseRequest(UUID.fromString(exerciseId), null, userId);

        log.info("Getting questions for exercise: {}", exerciseId);
        final QuestionResponse exerciseResponse = exerciseService.getExercise(exerciseRequest);

        return ResponseEntity.ok(exerciseResponse);
    }
}
