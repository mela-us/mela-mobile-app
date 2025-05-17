package com.hcmus.mela.lecture.controller;

import com.hcmus.mela.lecture.dto.response.GetTopicsResponse;
import com.hcmus.mela.lecture.service.TopicService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/topics")
@Slf4j
public class TopicController {

    private final TopicService topicService;

    @GetMapping
    @Operation(
            tags = "Math Category Service",
            summary = "Get all topics",
            description = "Get all topics existing in the system."
    )
    public ResponseEntity<GetTopicsResponse> getTopicsRequest() {
        log.info("Getting topics in system");
        GetTopicsResponse response = topicService.getTopicsResponse();

        return ResponseEntity.ok(response);
    }
}
