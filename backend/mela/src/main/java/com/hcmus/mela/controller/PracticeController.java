package com.hcmus.mela.controller;

import com.hcmus.mela.dto.service.ExerciseDto;
import com.hcmus.mela.dto.service.LevelDto;
import com.hcmus.mela.service.LevelService;
import com.hcmus.mela.service.PracticeService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/practice")
public class PracticeController {

    private final PracticeService practiceService;

    @GetMapping("/{lectureId}")
    @Operation(tags = "Practice Service", description = "Get all exercises.")
    public ResponseEntity<List<ExerciseDto>> getExercisesRequest(@PathVariable Integer lectureId) {
        return ResponseEntity.ok(practiceService.getExercisesByLectureId(lectureId));
    }



}
