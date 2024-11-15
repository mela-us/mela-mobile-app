package com.hcmus.mela.controller;

import com.hcmus.mela.repository.mongo.TopicRepository;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/topics")
public class TopicController {

    private final TopicRepository topicRepository;

    @GetMapping
    @Operation(tags = "Topic Service", description = "Get all topics.")
    public ResponseEntity<?> topicRequest() {

        return ResponseEntity.ok(topicRepository.findByTopicId(1));
    }

}
