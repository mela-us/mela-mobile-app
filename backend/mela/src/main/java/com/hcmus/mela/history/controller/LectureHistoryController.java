package com.hcmus.mela.history.controller;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.history.dto.request.SaveLectureSectionRequest;
import com.hcmus.mela.history.dto.response.ExerciseResultResponse;
import com.hcmus.mela.history.dto.response.SaveLectureSectionResponse;
import com.hcmus.mela.history.service.ExerciseHistoryService;
import com.hcmus.mela.history.service.LectureHistoryService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/lecture-histories")
public class LectureHistoryController {

    private final LectureHistoryService lectureHistoryService;

    private final JwtTokenService jwtTokenService;

    @PostMapping()
    @Operation(tags = "History Service", description = "Save lecture section history.")
    public ResponseEntity<SaveLectureSectionResponse> saveExerciseHistory(
            @RequestHeader("Authorization") String authorizationHeader,
            @RequestBody SaveLectureSectionRequest saveLectureSectionRequest) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);
        SaveLectureSectionResponse response = lectureHistoryService.saveSection(userId, saveLectureSectionRequest);
        return ResponseEntity.ok(response);
    }
}
