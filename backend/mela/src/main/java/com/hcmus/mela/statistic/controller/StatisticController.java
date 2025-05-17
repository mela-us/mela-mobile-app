package com.hcmus.mela.statistic.controller;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.statistic.dto.dto.ActivityType;
import com.hcmus.mela.statistic.dto.response.GetStatisticsResponse;
import com.hcmus.mela.statistic.service.StatisticService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/api/statistics")
public class StatisticController {

    private final StatisticService statisticService;

    private final JwtTokenService jwtTokenService;

    @GetMapping("/{levelId}")
    @Operation(
            tags = "Statistic Service",
            summary = "Get statistics",
            description = "Get statistics of user in the system."
    )
    public ResponseEntity<GetStatisticsResponse> getStatisticsRequest(
            @Parameter(description = "Level Id", example = "c9dcb3d7-c80c-4431-afd7-c727c8e5ee5b")
            @PathVariable("levelId") UUID levelId,
            @Parameter(description = "Type of activity", example = "EXERCISE, TEST, LESSON, ALL, ...", required = false)
            @RequestParam(value = "type", required = false) String type,
            @RequestHeader("Authorization") String authorizationHeader) {
        ActivityType activityType = ActivityType.fromValue(type);
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);

        log.info("Getting statistics for user: {} with levelId: {} and type: {}", userId, levelId, activityType);
        GetStatisticsResponse response = statisticService.getStatisticByUserAndLevelAndType(
                userId,
                levelId,
                activityType);

        return ResponseEntity.ok(response);
    }
}
