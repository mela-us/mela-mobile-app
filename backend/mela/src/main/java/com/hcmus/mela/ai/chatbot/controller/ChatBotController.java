package com.hcmus.mela.ai.chatbot.controller;

import com.hcmus.mela.ai.chatbot.dto.request.ChatRequest;
import com.hcmus.mela.ai.chatbot.dto.response.ChatResponse;
import com.hcmus.mela.ai.chatbot.service.ConversationService;
import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.common.storage.StorageService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/chatbot/conversations")
@RequiredArgsConstructor
public class ChatBotController {
    private final ConversationService conversationService;
    private final JwtTokenService jwtTokenService;
    private final StorageService storageService;

    @PostMapping()
    public ResponseEntity<ChatResponse> createConversation(
            @Valid @RequestBody ChatRequest chatRequest,
            @RequestHeader(value = "Authorization") String authorizationHeader) {
        ChatResponse chatResponse = conversationService.createConversation(chatRequest);
        return ResponseEntity.ok(chatResponse);
    }

    @PostMapping("{conversationId}/messages")
    public ResponseEntity<ChatResponse> sendMessage(
            @Valid @RequestBody ChatRequest chatRequest,
            @RequestHeader(value = "Authorization") String authorizationHeader,
            @PathVariable String conversationId) {
        return ResponseEntity.ok(new ChatResponse(""));
    }

    @GetMapping("/files/upload-url")
    public ResponseEntity<Map<String, String>> getUploadUrl() {
        Map<String, String> urls = storageService.getUploadConversationFilePreSignedUrl(UUID.randomUUID().toString());

        return ResponseEntity.ok().body(
                Map.of("preSignedUrl", urls.get("preSignedUrl"), "fileUrl", urls.get("storedUrl"))
        );
    }
}
