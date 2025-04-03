package com.hcmus.mela.ai.chatbot.service;

import com.hcmus.mela.ai.chatbot.dto.request.CreateConversationRequestDto;
import com.hcmus.mela.ai.chatbot.dto.request.MessageRequestDto;
import com.hcmus.mela.ai.chatbot.dto.response.ConversationResponseDto;
import com.hcmus.mela.ai.chatbot.model.Message;

import java.util.List;
import java.util.UUID;

public interface ConversationService {
    Object identifyProblem(Message message);

    Object resolveConfusion(List<Message> messageList, String context);

    Object reviewSubmission(List<Message> messageList, String context);

    Object provideSolution(List<Message> messageList, String context);

    ConversationResponseDto getSolutionResponse(MessageRequestDto messageRequestDto, UUID conversationId, UUID userId);

    ConversationResponseDto getReviewSubmissionResponse(MessageRequestDto messageRequestDto, UUID conversationId, UUID userId);

    ConversationResponseDto sendMessage(MessageRequestDto messageRequestDto, UUID conversationId, UUID userId);

    ConversationResponseDto createConversation(UUID userId, CreateConversationRequestDto createConversationRequestDto);
}
