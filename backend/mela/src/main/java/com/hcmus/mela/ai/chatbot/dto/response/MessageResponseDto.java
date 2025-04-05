package com.hcmus.mela.ai.chatbot.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.UUID;

@Getter
@Setter
@Builder
@AllArgsConstructor
public class MessageResponseDto {
    private UUID messageId;
    private String role;
    private Object content;
    private Date timestamp;
}
