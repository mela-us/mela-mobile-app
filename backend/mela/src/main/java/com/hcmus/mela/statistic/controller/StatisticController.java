package com.hcmus.mela.statistic.controller;

import com.azure.core.annotation.QueryParam;
import com.hcmus.mela.statistic.dto.dto.ActivityType;
import com.hcmus.mela.statistic.dto.response.GetStatisticsResponse;
import com.hcmus.mela.history.service.ExerciseHistoryService;
import com.hcmus.mela.statistic.service.StatisticService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/statistics")
public class StatisticController {

    private final StatisticService statisticService;

    @GetMapping("/{levelId}")
    @Operation(tags = "Statistic Service", description = "Get all statistics.")
    public ResponseEntity<GetStatisticsResponse> getStatisticsRequest(
            @PathVariable("levelId") UUID levelId,
            @RequestParam(value = "type", required = false) String type,
            @RequestHeader("Authorization") String authorizationHeader) {
        ActivityType activityType = ActivityType.fromValue(type);
        GetStatisticsResponse response = statisticService.getStatisticByUserAndLevelAndType(
                authorizationHeader,
                levelId,
                activityType);
        return ResponseEntity.ok(response);
    }
}
