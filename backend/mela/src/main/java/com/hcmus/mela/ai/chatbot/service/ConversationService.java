package com.hcmus.mela.ai.chatbot.service;

import com.hcmus.mela.ai.chatbot.dto.request.ChatRequest;
import com.hcmus.mela.ai.chatbot.dto.response.ChatResponse;

public interface ConversationService {
    ChatResponse identifyProblem(ChatRequest chatRequest);
}
