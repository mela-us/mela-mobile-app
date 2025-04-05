package com.hcmus.mela.lecture.controller;

import com.hcmus.mela.lecture.dto.response.GetLevelsResponse;
import com.hcmus.mela.lecture.service.LevelService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/levels")
@Slf4j
public class LevelController {

    private final LevelService levelService;

    @GetMapping
    @Operation(
            tags = "Math Category Service",
            summary = "Get all levels",
            description = "Retrieves all levels existing in the system."
    )
    public ResponseEntity<GetLevelsResponse> getLevelsRequest() {
        log.info("Getting levels in system");
        GetLevelsResponse response = levelService.getLevelsResponse();

        return ResponseEntity.ok(response);
    }
}
