package com.hcmus.mela.ai.chatbot.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
public class CreateConversationResponseDto {
    private UUID conversationId;

    private String title;

    private List<MessageResponseDto> message;

    private ConversationMetadataDto metadata;
}
