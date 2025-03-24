package com.hcmus.mela.ai.client;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

@Component
@RequiredArgsConstructor
public class AiWebClient {
    private final AiClientProperties aiClientProperties;

    public WebClient getWebClientForChatBot() {
        return createWebClient(aiClientProperties.getChatBot().getProvider());
    }

    public WebClient getWebClientForExerciseHint() {
        return createWebClient(aiClientProperties.getExerciseHint().getProvider());
    }

    public WebClient getWebClientForExerciseGrading() {
        return createWebClient(aiClientProperties.getExerciseGrading().getProvider());
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
