package com.hcmus.mela.ai.chatbot.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Setter
@Getter
@Builder
public class ConversationInfoDto {
    private UUID conversationId;

    private String title;

    private ConversationMetadataDto metadata;
}
