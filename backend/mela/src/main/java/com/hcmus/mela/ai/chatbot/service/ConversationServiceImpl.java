package com.hcmus.mela.ai.chatbot.service;

import com.hcmus.mela.ai.chatbot.dto.request.ChatRequest;
import com.hcmus.mela.ai.chatbot.dto.response.ChatResponse;
import com.hcmus.mela.ai.chatbot.exception.ChatBotException;
import com.hcmus.mela.ai.chatbot.model.ChatBotPrompt;
import com.hcmus.mela.ai.chatbot.repository.ConversationRepository;
import com.hcmus.mela.ai.client.config.AiClientProperties;
import com.hcmus.mela.ai.client.web.AiWebClient;
import com.hcmus.mela.ai.client.builder.AiRequestBodyFactory;
import com.hcmus.mela.ai.client.filter.AiResponseFilter;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ConversationServiceImpl implements ConversationService {

    private final AiWebClient aiWebClient;
    private final AiClientProperties.ChatBot chatBotProperties;
    private final ChatBotPrompt chatBotPrompt;
    private final AiRequestBodyFactory aiRequestBodyFactory;
    private final AiResponseFilter aiResponseFilter;
    private final ConversationRepository conversationRepository;

    public ConversationServiceImpl(AiWebClient aiWebClient,
                                   AiClientProperties aiClientProperties,
                                   ChatBotPrompt chatBotPrompt,
                                   AiRequestBodyFactory aiRequestBodyFactory,
                                   ConversationRepository conversationRepository,
                                   AiResponseFilter aiResponseFilter) {
        this.aiWebClient = aiWebClient;
        this.chatBotProperties = aiClientProperties.getChatBot();
        this.chatBotPrompt = chatBotPrompt;
        this.aiRequestBodyFactory = aiRequestBodyFactory;
        this.conversationRepository = conversationRepository;
        this.aiResponseFilter = aiResponseFilter;
    }

    @Override
    public Object identifyProblem(ChatRequest chatRequest) {

        String textData = chatRequest.getText() != null ? chatRequest.getText() : "";
        List<String> imageUrls = chatRequest.getImageUrl() != null ? List.of(chatRequest.getImageUrl()) : List.of();

        Object requestBody = aiRequestBodyFactory.createRequestBodyForChatBot(
                chatBotPrompt.getIdentifyProblem().getInstruction(),
                textData,
                imageUrls,
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
        Object response = identifyProblem(chatRequest);

        String responseText = aiResponseFilter.getMessage(response);
        int usageToken = aiResponseFilter.getUsageToken(response);

        return new ChatResponse(responseText);
    }
}