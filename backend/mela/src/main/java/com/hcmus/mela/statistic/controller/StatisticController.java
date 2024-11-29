package com.hcmus.mela.statistic.controller;

import com.hcmus.mela.lecture.dto.response.GetLevelsResponse;
import com.hcmus.mela.lecture.service.LevelServiceImpl;
import com.hcmus.mela.statistic.dto.response.GetStatisticsResponse;
import com.hcmus.mela.statistic.service.StatisticServiceImpl;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/statistics")
public class StatisticController {

    private final StatisticServiceImpl statisticService;

    @GetMapping
    @Operation(tags = "Statistic Service", description = "Get all statistics.")
    public ResponseEntity<GetStatisticsResponse> getStatisticsRequest(
            @RequestHeader("Authorization") String authorizationHeader
    ) {
        return ResponseEntity.ok(statisticService.getStatisticByUserId(authorizationHeader));
    }

}
