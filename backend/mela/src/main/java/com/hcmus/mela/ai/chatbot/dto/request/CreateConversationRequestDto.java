package com.hcmus.mela.ai.chatbot.dto.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateConversationRequestDto {
    @NotNull(message = "Message cannot be null")
    @Valid
    private MessageRequestDto message;
}
