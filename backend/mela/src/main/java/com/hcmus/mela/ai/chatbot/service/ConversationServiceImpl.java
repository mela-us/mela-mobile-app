package com.hcmus.mela.ai.chatbot.service;

import com.hcmus.mela.ai.chatbot.dto.request.ChatRequest;
import com.hcmus.mela.ai.chatbot.dto.response.ChatResponse;
import com.hcmus.mela.ai.chatbot.model.ChatBotPrompt;
import com.hcmus.mela.ai.chatbot.model.Conversation;
import com.hcmus.mela.ai.chatbot.repository.ConversationRepository;
import com.hcmus.mela.ai.client.AiClientProperties;
import com.hcmus.mela.ai.client.AiWebClient;
import com.hcmus.mela.ai.client.builder.AiRequestBodyFactory;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class ConversationServiceImpl implements ConversationService {

    private final AiWebClient aiWebClient;
    private final AiClientProperties.ChatBot chatBotProperties;
    private final ChatBotPrompt chatBotPrompt;
    private final AiRequestBodyFactory aiRequestBodyFactory;
    private final ConversationRepository conversationRepository;

    public ConversationServiceImpl(AiWebClient aiWebClient,
                                   AiClientProperties aiClientProperties,
                                   ChatBotPrompt chatBotPrompt,
                                   AiRequestBodyFactory aiRequestBodyFactory,
                                   ConversationRepository conversationRepository) {
        this.aiWebClient = aiWebClient;
        this.chatBotProperties = aiClientProperties.getChatBot();
        this.chatBotPrompt = chatBotPrompt;
        this.aiRequestBodyFactory = aiRequestBodyFactory;
        this.conversationRepository = conversationRepository;
    }

    @Override
    public Object identifyProblem(ChatRequest chatRequest) {
        Object requestBody = aiRequestBodyFactory.createRequestBodyForChatBot(
                chatBotPrompt.getIdentifyProblem().getInstruction(),
                chatRequest.getText(),
                List.of(chatRequest.getImageUrl()),
                chatBotProperties);

        return aiWebClient.fetchAiResponse(chatBotProperties, requestBody);
    }

    @Override
    public Object resolveConfusion(ChatRequest chatRequest) {
        return null;
    }

    @Override
    public Object reviewSubmission(ChatRequest chatRequest) {
        return null;
    }

    @Override
    public Object provideSolution(ChatRequest chatRequest) {
        return null;
    }

    @Override
    public ChatResponse sendMessage(ChatRequest chatRequest, String conversationId) {
        return null;
    }

    @Override
    public ChatResponse createConversation(ChatRequest chatRequest) {
        identifyProblem(chatRequest);
        return null;
    }
}