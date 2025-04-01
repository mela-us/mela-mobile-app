package com.hcmus.mela.ai.chatbot.dto.response;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
public class ConversationMetadataDto {
    private String status;
    private Date createdAt;
}
