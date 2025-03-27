package com.hcmus.mela.ai.chatbot.service;

import com.hcmus.mela.ai.chatbot.dto.request.ChatRequest;
import com.hcmus.mela.ai.chatbot.dto.response.ChatResponse;
import com.hcmus.mela.ai.chatbot.model.ChatBotPrompt;
import com.hcmus.mela.ai.client.AiClientProperties;
import com.hcmus.mela.ai.client.AiWebClient;
import com.hcmus.mela.ai.client.builder.AiRequestBodyFactory;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ConversationServiceImpl implements ConversationService {

    private final AiWebClient aiWebClient;
    private final AiClientProperties.ChatBot chatBotProperties;
    private final ChatBotPrompt chatBotPrompt;
    private final AiRequestBodyFactory aiRequestBodyFactory;

    public ConversationServiceImpl(AiWebClient aiWebClient,
                                   AiClientProperties aiClientProperties,
                                   ChatBotPrompt chatBotPrompt,
                                   AiRequestBodyFactory aiRequestBodyFactory) {
        this.aiWebClient = aiWebClient;
        this.chatBotProperties = aiClientProperties.getChatBot();
        this.chatBotPrompt = chatBotPrompt;
        this.aiRequestBodyFactory = aiRequestBodyFactory;
    }

    @Override
    public ChatResponse identifyProblem(ChatRequest chatRequest) {
        Object requestBody = aiRequestBodyFactory.createRequestBodyForQuestionHint(
                chatBotPrompt.getIdentifyProblem().getInstruction(),
                chatRequest.getText(),
                List.of(chatRequest.getImageUrl()),
                chatBotProperties);

        Object response = aiWebClient.fetchAiResponse(chatBotProperties, requestBody);
        return new ChatResponse(response);
    }
}