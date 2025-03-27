package com.hcmus.mela.ai.chatbot.service;

import com.hcmus.mela.ai.chatbot.dto.request.ChatRequest;
import com.hcmus.mela.ai.chatbot.dto.response.ChatResponse;

public interface ConversationService {
    Object identifyProblem(ChatRequest chatRequest);

    Object resolveConfusion(ChatRequest chatRequest);

    Object reviewSubmission(ChatRequest chatRequest);
    Object provideSolution(ChatRequest chatRequest);

    ChatResponse sendMessage(ChatRequest chatRequest, String conversationId);

    ChatResponse createConversation(ChatRequest chatRequest);
}
