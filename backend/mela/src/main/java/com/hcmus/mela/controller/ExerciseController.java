package com.hcmus.mela.controller;

import com.hcmus.mela.dto.request.ExerciseRequest;
import com.hcmus.mela.dto.response.ExerciseResponse;
import com.hcmus.mela.service.ExerciseService;
import com.hcmus.mela.model.mongo.Exercise;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.autoconfigure.security.oauth2.resource.OAuth2ResourceServerProperties;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class ExerciseController {
    private final ExerciseService exerciseService;



    @RequestMapping(value = "/lectures/{lectureId}/exercises", method = RequestMethod.GET)
    @Operation(tags = "Exercise Service", description = "You can find a list of exercises belonging to a lecture from " +
            "the system by accessing the appropriate path.")
    public ResponseEntity<ExerciseResponse> getExerciseInLecture(
            @PathVariable Integer lectureId,
            @AuthenticationPrincipal OAuth2ResourceServerProperties.Jwt accessToken) {

        ExerciseRequest exerciseRequest = new ExerciseRequest(null, lectureId);

        final ExerciseResponse exerciseResponse = exerciseService.getAllExercisesInLecture(exerciseRequest);

        return ResponseEntity.ok(exerciseResponse);
    }

    @RequestMapping(value = "/exercises/{exerciseId}", method = RequestMethod.GET)
    @Operation(tags = "Exercise Service", description = "You can find a single exercise from the system by accessing the " +
            "appropriate path.")
    public ResponseEntity<ExerciseResponse> getExercise(
            @PathVariable Integer exerciseId,
            @AuthenticationPrincipal OAuth2ResourceServerProperties.Jwt accessToken) {

        ExerciseRequest exerciseRequest = new ExerciseRequest(exerciseId, null);

        final ExerciseResponse exerciseResponse = exerciseService.getExercise(exerciseRequest);

        return ResponseEntity.ok(exerciseResponse);
    }

}
