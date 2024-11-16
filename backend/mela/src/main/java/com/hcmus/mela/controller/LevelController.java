package com.hcmus.mela.controller;

import com.hcmus.mela.dto.service.LevelDto;
import com.hcmus.mela.service.LevelService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/levels")
public class LevelController {

    private final LevelService levelService;

    @GetMapping
    @Operation(tags = "Level Service", description = "Get all levels.")
    public ResponseEntity<List<LevelDto>> getLevelRequest() {

        return ResponseEntity.ok(levelService.getAllLevels());
    }

}
