package com.hcmus.mela.exercise.controller;

import com.hcmus.mela.exercise.dto.request.ExerciseRequest;
import com.hcmus.mela.exercise.dto.request.ExerciseResultRequest;
import com.hcmus.mela.exercise.dto.response.ExerciseResponse;
import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.auth.security.utils.SecurityConstants;
import com.hcmus.mela.exercise.dto.response.ExerciseResultResponse;
import com.hcmus.mela.exercise.dto.response.QuestionResponse;
import com.hcmus.mela.exercise.service.ExerciseResultService;
import com.hcmus.mela.exercise.service.ExerciseService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.AllArgsConstructor;
import org.apache.logging.log4j.util.Strings;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@AllArgsConstructor
@RequestMapping("/api")
public class ExerciseController {
    private final ExerciseService exerciseService;
    private final ExerciseResultService exerciseResultService;

    private JwtTokenService jwtTokenService;

    @RequestMapping(value = "/lectures/{lectureId}/exercises", method = RequestMethod.GET)
    @Operation(tags = "Exercise Service", description = "You can find a list of exercises belonging to a lecture from " +
            "the system by accessing the appropriate path.")
    public ResponseEntity<ExerciseResponse> getExerciseInLecture(
            @PathVariable String lectureId,
            @RequestHeader("Authorization") String authorizationHeader) {
        String token = authorizationHeader.replace(SecurityConstants.TOKEN_PREFIX, Strings.EMPTY);
        UUID userId = jwtTokenService.getUserIdFromToken(token);

        ExerciseRequest exerciseRequest = new ExerciseRequest(null, UUID.fromString(lectureId), userId);
        final ExerciseResponse exerciseResponse = exerciseService.getAllExercisesInLecture(exerciseRequest);
        return ResponseEntity.ok(exerciseResponse);
    }

    @RequestMapping(value = "/exercises/{exerciseId}", method = RequestMethod.GET)
    @Operation(tags = "Exercise Service", description = "You can find a single exercise from the system by accessing the " +
            "appropriate path.")
    public ResponseEntity<QuestionResponse> getExercise(
            @PathVariable String exerciseId,
            @RequestHeader("Authorization") String authorizationHeader) {
        String token = jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader);
        UUID userId = jwtTokenService.getUserIdFromToken(token);

        ExerciseRequest exerciseRequest = new ExerciseRequest(UUID.fromString(exerciseId), null, userId);
        final QuestionResponse exerciseResponse = exerciseService.getExercise(exerciseRequest);
        return ResponseEntity.ok(exerciseResponse);
    }
}
