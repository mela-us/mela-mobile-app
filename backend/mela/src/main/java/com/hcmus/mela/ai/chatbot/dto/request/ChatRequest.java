package com.hcmus.mela.ai.chatbot.dto.request;

import com.hcmus.mela.common.validator.AtLeastOneNotEmpty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AtLeastOneNotEmpty(fields = {"text", "imageUrl"})
public class ChatRequest {
    private String text;

    private String imageUrl;
}
