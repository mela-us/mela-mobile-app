package com.hcmus.mela.history.controller;

import com.hcmus.mela.history.dto.request.SaveLectureSectionRequest;
import com.hcmus.mela.history.dto.response.ExerciseResultResponse;
import com.hcmus.mela.history.dto.response.SaveLectureSectionResponse;
import com.hcmus.mela.history.service.ExerciseHistoryService;
import com.hcmus.mela.history.service.LectureHistoryService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/lecture-histories")
public class LectureHistoryController {

    private final LectureHistoryService lectureHistoryService;

    @PostMapping()
    @Operation(tags = "History Service", description = "Save lecture history.")
    public ResponseEntity<SaveLectureSectionResponse> saveExerciseHistory(
            @RequestHeader("Authorization") String authorizationHeader,
            @RequestBody SaveLectureSectionRequest saveLectureSectionRequest) {
        SaveLectureSectionResponse response = lectureHistoryService.saveSection(authorizationHeader, saveLectureSectionRequest);
        return ResponseEntity.ok(response);
    }
}
