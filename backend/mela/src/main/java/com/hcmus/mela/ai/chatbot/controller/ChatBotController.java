package com.hcmus.mela.ai.chatbot.controller;

import com.hcmus.mela.ai.chatbot.service.ConversationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/chat-bot/conversations")
@RequiredArgsConstructor
public class ChatBotController {
    private final ConversationService conversationService;

    @PostMapping("/test-chat")
    public ResponseEntity<String> testChat(@RequestHeader(value = "Authorization") String authorizationHeader) {
        return ResponseEntity.ok(conversationService.testChat());
    }
}
