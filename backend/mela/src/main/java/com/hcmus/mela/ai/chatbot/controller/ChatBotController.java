package com.hcmus.mela.ai.chatbot.controller;

import com.hcmus.mela.ai.chatbot.dto.request.CreateConversationRequestDto;
import com.hcmus.mela.ai.chatbot.dto.request.MessageRequestDto;
import com.hcmus.mela.ai.chatbot.dto.response.CreateConversationResponseDto;
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
    public ResponseEntity<CreateConversationResponseDto> createConversation(
            @Valid @RequestBody CreateConversationRequestDto createConversationRequestDto,
            @RequestHeader(value = "Authorization") String authorizationHeader) {
        // Extract user id from JWT token
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);

        // Create conversation
        CreateConversationResponseDto createConversationResponseDto = conversationService.createConversation(userId, createConversationRequestDto);
        return ResponseEntity.ok(createConversationResponseDto);
    }

    @PostMapping("{conversationId}/messages")
    public ResponseEntity<CreateConversationResponseDto> sendMessage(
            @Valid @RequestBody MessageRequestDto messageRequestDto,
            @PathVariable String conversationId) {
        return ResponseEntity.ok(null);
    }

    @GetMapping("/files/upload-url")
    public ResponseEntity<Map<String, String>> getUploadUrl() {
        Map<String, String> urls = storageService.getUploadConversationFilePreSignedUrl(UUID.randomUUID().toString());

        return ResponseEntity.ok().body(
                Map.of("preSignedUrl", urls.get("preSignedUrl"), "fileUrl", urls.get("storedUrl"))
        );
    }
}
