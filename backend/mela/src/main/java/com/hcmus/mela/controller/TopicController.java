package com.hcmus.mela.controller;

import com.hcmus.mela.dto.service.TopicDto;
import com.hcmus.mela.service.TopicService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/topics")
public class TopicController {

    private final TopicService topicService;

    @GetMapping
    @Operation(tags = "Topic Service", description = "Get all topics.")
    public ResponseEntity<List<TopicDto>> getTopicRequest() {

        return ResponseEntity.ok(topicService.getAllTopics());
    }

}
