package com.hcmus.mela.ai.question.hint.controller;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@AllArgsConstructor
@RequestMapping("/api")
public class QuestionHintController {

    @GetMapping("/{questionId}/hint/term")
    public List<String> generateTerm(@PathVariable UUID questionId,
                                     @RequestHeader(value = "Authorization") String authorizationHeader) {
        
    }
}


