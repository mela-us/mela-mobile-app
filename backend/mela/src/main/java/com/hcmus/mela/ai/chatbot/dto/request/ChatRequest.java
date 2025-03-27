package com.hcmus.mela.ai.chatbot.dto.request;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ChatRequest {
    private String text;
    private String imageUrl;

    public String getUserMessage() {
        return text + " " + imageUrl;
    }
}
