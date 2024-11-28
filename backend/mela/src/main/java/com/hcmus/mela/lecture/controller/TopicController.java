package com.hcmus.mela.lecture.controller;

import com.hcmus.mela.lecture.dto.dto.TopicDto;
import com.hcmus.mela.lecture.dto.response.GetTopicsResponse;
import com.hcmus.mela.lecture.service.TopicServiceImpl;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/topics")
public class TopicController {

    private final TopicServiceImpl topicService;

    @GetMapping
    @Operation(tags = "Topic Service", description = "Get all topics.")
    public ResponseEntity<GetTopicsResponse> getTopicsRequest() {

        return ResponseEntity.ok(topicService.getAllTopics());
    }

}
