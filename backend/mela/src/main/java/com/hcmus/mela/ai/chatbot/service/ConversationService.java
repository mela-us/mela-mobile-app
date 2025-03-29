package com.hcmus.mela.ai.chatbot.service;

import com.hcmus.mela.ai.chatbot.dto.request.CreateConversationRequestDto;
import com.hcmus.mela.ai.chatbot.dto.request.MessageRequestDto;
import com.hcmus.mela.ai.chatbot.dto.response.CreateConversationResponseDto;

import java.util.UUID;

public interface ConversationService {
    Object identifyProblem(MessageRequestDto messageRequestDto);

    Object resolveConfusion(MessageRequestDto messageRequestDto);

    Object reviewSubmission(MessageRequestDto messageRequestDto);
    Object provideSolution(MessageRequestDto messageRequestDto);

    CreateConversationResponseDto sendMessage(MessageRequestDto messageRequestDto, String conversationId);

    CreateConversationResponseDto createConversation(UUID userId, CreateConversationRequestDto createConversationRequestDto);
}
