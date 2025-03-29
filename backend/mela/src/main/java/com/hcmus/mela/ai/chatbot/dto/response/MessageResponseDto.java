package com.hcmus.mela.ai.chatbot.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
public class MessageResponseDto {
    private String role;
    private Object content;
    private Date timestamp;
}
