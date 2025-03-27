package com.hcmus.mela.ai.client;

import com.hcmus.mela.ai.client.builder.AiResponseFactory;
import lombok.AllArgsConstructor;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.stereotype.Component;

@Component
@AllArgsConstructor
public class AiWebClient {
    private final AiClientProperties aiClientProperties;
    private final AiResponseFactory aiResponseFactory;

    public WebClient getWebClientForChatBot() {
        return createWebClient(aiClientProperties.getChatBot().getProvider());
    }

    public WebClient getWebClientForQuestionHint() {
        return createWebClient(aiClientProperties.getQuestionHint().getProvider());
    }

    public Object fetchAiResponse(AiClientProperties.ChatBot chatBotProperties, Object requestBody) {
        String provider = chatBotProperties.getProvider();
        Class<?> responseType = aiResponseFactory.getResponseType(provider);

        return getWebClientForChatBot()
                .post()
                .uri(chatBotProperties.getPath())
                .bodyValue(requestBody)
                .retrieve()
                .bodyToMono(responseType)
                .block();
    }

    private WebClient createWebClient(String provider) {
        AiClientProperties.Provider providerConfig = aiClientProperties.getProviders().get(provider);
        if (providerConfig == null) {
            throw new IllegalArgumentException("Unsupported AI provider: " + provider);
        }
        return WebClient.builder()
                .baseUrl(providerConfig.getBaseUrl())
                .defaultHeader("Authorization", "Bearer " + providerConfig.getKey())
                .defaultHeader("Content-Type", "application/json")
                .build();
    }
}
