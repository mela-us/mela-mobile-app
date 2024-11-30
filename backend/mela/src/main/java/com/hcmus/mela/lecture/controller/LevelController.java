package com.hcmus.mela.lecture.controller;

import com.hcmus.mela.lecture.dto.response.GetLevelsResponse;
import com.hcmus.mela.lecture.service.LevelServiceImpl;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/levels")
public class LevelController {

    private final LevelServiceImpl levelService;

    @GetMapping
    @Operation(tags = "Level Service", description = "Get all levels.")
    public ResponseEntity<GetLevelsResponse> getLevelsRequest() {

        return ResponseEntity.ok(levelService.getAllLevels());
    }
}
