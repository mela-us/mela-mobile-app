package com.hcmus.mela.history.controller;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.history.dto.request.SaveLectureSectionRequest;
import com.hcmus.mela.history.dto.response.SaveLectureSectionResponse;
import com.hcmus.mela.history.service.LectureHistoryService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/api/lecture-histories")
public class LectureHistoryController {

    private final LectureHistoryService lectureHistoryService;

    private final JwtTokenService jwtTokenService;

    @PostMapping()
    @Operation(
            tags = "History Service",
            summary = "Save section",
            description = "Save learning section of user in the system."
    )
    public ResponseEntity<SaveLectureSectionResponse> saveExerciseHistory(
            @RequestHeader("Authorization") String authorizationHeader,
            @RequestBody SaveLectureSectionRequest saveLectureSectionRequest) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);

        log.info("Saving lecture section for user: {}", userId);
        SaveLectureSectionResponse response = lectureHistoryService.saveSection(userId, saveLectureSectionRequest);

        return ResponseEntity.ok(response);
    }
}
