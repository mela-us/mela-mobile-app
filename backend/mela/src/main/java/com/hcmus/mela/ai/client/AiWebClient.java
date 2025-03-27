package com.hcmus.mela.ai.client;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hcmus.mela.ai.client.builder.AiResponseFactory;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatusCode;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClientResponseException;
import reactor.core.publisher.Mono;

/**
 * Client for making HTTP requests to AI service providers.
 * This class creates and manages WebClient instances for different AI features
 * and handles communication with external AI APIs.
 */
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

    /**
     * Makes an API request to the AI provider and fetches the response.
     *
     * @param aiFeatureProperties The properties for the AI feature
     * @param requestBody The request payload to send to the AI provider
     * @return The response from the AI provider, or null if there was an error
     */
    public Object fetchAiResponse(AiFeatureProperties aiFeatureProperties, Object requestBody) {
        String provider = aiFeatureProperties.getProvider();
        Class<?> responseType = aiResponseFactory.getResponseType(provider);
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonRequest;
        try {
            jsonRequest = objectMapper.writeValueAsString(requestBody);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        System.out.println(jsonRequest);

        // Make the API request
        try {
            return getWebClientForChatBot()
                    .post()
                    .uri(aiFeatureProperties.getPath())
                    .bodyValue(requestBody)
                    .retrieve()
                    .onStatus(HttpStatusCode::isError, clientResponse ->
                            clientResponse.bodyToMono(String.class).flatMap(body ->
                                    Mono.error(new RuntimeException("API Error: " + clientResponse.statusCode() + "\nBody: " + body))
                            )
                    )
                    .bodyToMono(responseType)
                    .block();
        } catch (WebClientResponseException e) {
            System.err.println("HTTP Error: " + e.getStatusCode());
            System.err.println("Response Body: " + e.getResponseBodyAsString());
            return null;
        } catch (Exception e) {
            System.err.println("Unexpected Error: " + e.getMessage());
            return null;
        }

    }

    /**
     * Creates a WebClient configured for a specific AI provider.
     *
     * @param provider The name of the AI provider to configure the WebClient for
     * @return A configured WebClient instance
     * @throws IllegalArgumentException if the provider is not supported
     */
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
