package com.hcmus.mela.ai.chatbot.service;

import com.hcmus.mela.ai.chatbot.dto.request.ChatRequest;
import com.hcmus.mela.ai.chatbot.dto.response.ChatResponse;
import com.hcmus.mela.ai.chatbot.model.ChatBotPrompt;
import com.hcmus.mela.ai.client.AiClientProperties;
import com.hcmus.mela.ai.client.AiWebClient;
import com.hcmus.mela.ai.client.builder.AiRequestBodyFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Service
public class ConversationServiceImpl implements ConversationService {

    private final WebClient webClient;
    private final AiClientProperties.ChatBot chatBotProperties;
    private final ChatBotPrompt chatBotPrompt;
    private final AiRequestBodyFactory aiRequestBodyFactory;

    public ConversationServiceImpl
            (
                    AiWebClient aiWebClient,
                    AiClientProperties aiClientProperties,
                    ChatBotPrompt chatBotPrompt,
                    AiRequestBodyFactory aiRequestBodyFactory
            ) {
        this.webClient = aiWebClient.getWebClientForChatBot();
        this.chatBotProperties = aiClientProperties.getChatBot();
        this.chatBotPrompt = chatBotPrompt;
        this.aiRequestBodyFactory = aiRequestBodyFactory;
    }

    @Override
    public ChatResponse identifyProblem(ChatRequest chatRequest) {
        String instruction = chatBotPrompt.getIdentifyProblem().getInstruction();

        Object requestBody = aiRequestBodyFactory.createRequestBody(
                chatBotProperties.getProvider(),
                instruction,
                chatRequest.getUserMessage(),
                chatBotProperties.getModel());

        String response = webClient.post()
                .uri(chatBotProperties.getPath())
                .bodyValue(requestBody)
                .retrieve()
                .onStatus(
                        status -> status.is4xxClientError() || status.is5xxServerError(),
                        clientResponse -> clientResponse.bodyToMono(String.class)
                                .flatMap(errorBody -> {
                                    System.err.println("API Error: " + errorBody);
                                    return Mono.error(new RuntimeException("API Error: " + errorBody));
                                })
                )
                .bodyToMono(String.class)
                .block();

        return new ChatResponse(response);
    }
}
