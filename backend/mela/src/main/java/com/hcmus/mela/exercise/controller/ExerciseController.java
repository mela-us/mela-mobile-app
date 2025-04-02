package com.hcmus.mela.exercise.controller;

import com.hcmus.mela.exercise.dto.request.ExerciseRequest;
import com.hcmus.mela.exercise.dto.response.ExerciseResponse;
import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.exercise.dto.response.QuestionResponse;
import com.hcmus.mela.exercise.service.ExerciseService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@AllArgsConstructor
@RequestMapping("/api")
public class ExerciseController {

    private final ExerciseService exerciseService;

    private JwtTokenService jwtTokenService;

    @RequestMapping(value = "/lectures/{lectureId}/exercises", method = RequestMethod.GET)
    @Operation(tags = "Exercise Service", description = "You can find a list of exercises belonging to a lecture from " +
            "the system by accessing the appropriate path.")
    public ResponseEntity<ExerciseResponse> getExerciseInLecture(
            @Parameter(description = "Lecture id", example = "[54c3abc5-3e8b-4017-acc2-c1005cd51c28, 9c50c1a3-c467-4bcd-a2dd-5db556e69828, 16b21202-b379-4f01-ab08-88d28ecbe94f, 40864bcb-777f-4004-a85a-1482bf66192d]")
            @PathVariable String lectureId,
            @RequestHeader("Authorization") String authorizationHeader) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);
        ExerciseRequest exerciseRequest = new ExerciseRequest(null, UUID.fromString(lectureId), userId);
        final ExerciseResponse exerciseResponse = exerciseService.getAllExercisesInLecture(exerciseRequest);
        return ResponseEntity.ok(exerciseResponse);
    }

    @RequestMapping(value = "/exercises/{exerciseId}", method = RequestMethod.GET)
    @Operation(tags = "Exercise Service", description = "You can find a single exercise from the system by accessing the " +
            "appropriate path.")
    public ResponseEntity<QuestionResponse> getExercise(
            @Parameter(description = "Exercise id", example = "[b705289f-888d-44be-a894-c7d0db1cec67, e4d553bc-7f5e-4285-886d-98b30d7c1663, ce973562-6e10-426f-a26f-0ae3ee8c1b7c, 904553a4-186e-4889-bb5f-19de4c64522d]")
            @PathVariable String exerciseId,
            @RequestHeader("Authorization") String authorizationHeader) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);
        ExerciseRequest exerciseRequest = new ExerciseRequest(UUID.fromString(exerciseId), null, userId);
        final QuestionResponse exerciseResponse = exerciseService.getExercise(exerciseRequest);
        return ResponseEntity.ok(exerciseResponse);
    }
}
