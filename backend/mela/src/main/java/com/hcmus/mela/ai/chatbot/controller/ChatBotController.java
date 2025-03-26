package com.hcmus.mela.ai.chatbot.controller;

import com.hcmus.mela.ai.chatbot.dto.request.ChatRequest;
import com.hcmus.mela.ai.chatbot.dto.response.ChatResponse;
import com.hcmus.mela.ai.chatbot.service.ConversationService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/chat-bot/conversations")
@RequiredArgsConstructor
public class ChatBotController {
    private final ConversationService conversationService;

    @PostMapping()
    public ResponseEntity<ChatResponse> startConversation(
            @Valid @RequestBody ChatRequest chatRequest,
            @RequestHeader(value = "Authorization") String authorizationHeader) {
        return ResponseEntity.ok(conversationService.identifyProblem(chatRequest));
    }
}
