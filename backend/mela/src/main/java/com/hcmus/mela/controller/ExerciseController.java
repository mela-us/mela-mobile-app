package com.hcmus.mela.controller;

import com.hcmus.mela.dto.request.ExerciseRequest;
import com.hcmus.mela.dto.response.ExerciseResponse;
import com.hcmus.mela.security.jwt.JwtTokenService;
import com.hcmus.mela.security.utils.SecurityConstants;
import com.hcmus.mela.service.ExerciseService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.AllArgsConstructor;
import org.apache.logging.log4j.util.Strings;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
            @PathVariable Integer lectureId,
            @RequestHeader("Authorization") String authorizationHeader) {
        String token = authorizationHeader.replace(SecurityConstants.TOKEN_PREFIX, Strings.EMPTY);

        Integer userId = jwtTokenService.getUserIdFromToken(token).intValue();

        ExerciseRequest exerciseRequest = new ExerciseRequest(null, lectureId, userId);

        final ExerciseResponse exerciseResponse = exerciseService.getAllExercisesInLecture(exerciseRequest);

        return ResponseEntity.ok(exerciseResponse);
    }

    @RequestMapping(value = "/exercises/{exerciseId}", method = RequestMethod.GET)
    @Operation(tags = "Exercise Service", description = "You can find a single exercise from the system by accessing the " +
            "appropriate path.")
    public ResponseEntity<ExerciseResponse> getExercise(
            @PathVariable Integer exerciseId,
            @RequestHeader("Authorization") String authorizationHeader) {

        String token = jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader);

        Integer userId = jwtTokenService.getUserIdFromToken(token).intValue();

        ExerciseRequest exerciseRequest = new ExerciseRequest(exerciseId, null, userId);

        final ExerciseResponse exerciseResponse = exerciseService.getExercise(exerciseRequest);

        return ResponseEntity.ok(exerciseResponse);
    }

}
