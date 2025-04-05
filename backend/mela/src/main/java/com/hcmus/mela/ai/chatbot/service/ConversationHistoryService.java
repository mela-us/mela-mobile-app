package com.hcmus.mela.ai.chatbot.service;

import com.hcmus.mela.ai.chatbot.dto.request.GetConversationHistoryRequestDto;
import com.hcmus.mela.ai.chatbot.dto.request.GetListMessagesRequestDto;
import com.hcmus.mela.ai.chatbot.dto.response.ConversationInfoDto;
import com.hcmus.mela.ai.chatbot.dto.response.GetConversationHistoryResponseDto;
import com.hcmus.mela.ai.chatbot.dto.response.GetListMessagesResponseDto;

import java.util.UUID;

public interface ConversationHistoryService {
    GetConversationHistoryResponseDto getConversationHistory(GetConversationHistoryRequestDto request, UUID userId);

    ConversationInfoDto getConversation(UUID conversationId);

    GetListMessagesResponseDto getListMessages(GetListMessagesRequestDto request, UUID conversationId);

    void deleteConversation(UUID conversationId);
}
