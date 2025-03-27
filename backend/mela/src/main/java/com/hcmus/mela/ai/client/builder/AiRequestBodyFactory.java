package com.hcmus.mela.ai.client.builder;

import com.hcmus.mela.ai.client.AiFeatureProperties;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * Factory for creating AI request bodies based on the provider.
 * This class determines which implementation of AiRequestBodyBuilder to use
 * based on the provider specified in the AI feature properties.
 */
@Component
public class AiRequestBodyFactory {
    private final Map<String, AiRequestBodyBuilder> requestBodyBuilders;

    /**
     * Constructor that injects all available request body builders.
     * The builders are mapped by bean name, which should follow the pattern
     * "{providerName}RequestBodyBuilder".
     *
     * @param requestBodyBuilders Map of request body builders injected by Spring
     */
    public AiRequestBodyFactory(Map<String, AiRequestBodyBuilder> requestBodyBuilders) {
        this.requestBodyBuilders = requestBodyBuilders;
    }

    /**
     * Creates a request body for the question hint feature.
     *
     * @param instruction System instruction for the AI
     * @param textData Text content of the question
     * @param imageUrls List of image URLs to include in the request
     * @param aiFeatureProperties Configuration properties for the AI feature
     * @return A request body object formatted for the specific AI provider
     * @throws IllegalArgumentException if the provider is not supported
     */
    public Object createRequestBodyForQuestionHint(String instruction, String textData, List<String> imageUrls, AiFeatureProperties aiFeatureProperties) {
        AiRequestBodyBuilder builder = requestBodyBuilders.get(aiFeatureProperties.getProvider() + "RequestBodyBuilder");

        if (builder == null) {
            throw new IllegalArgumentException("Unknown provider: " + aiFeatureProperties.getProvider() + ". Available providers: " + requestBodyBuilders.keySet());
        }

        return builder.buildRequestBodyForQuestionHint(instruction, textData, imageUrls, aiFeatureProperties);
    }

    /**
     * Creates a request body for the chat bot feature.
     *
     * @param instruction System instruction for the AI
     * @param message List of message objects containing role and content
     * @param aiFeatureProperties Configuration properties for the AI feature
     * @return A request body object formatted for the specific AI provider
     * @throws IllegalArgumentException if the provider is not supported
     */
    public Object createRequestBodyForChatBot(String instruction, List<Map<String, String>> message, AiFeatureProperties aiFeatureProperties) {
        AiRequestBodyBuilder builder = requestBodyBuilders.get(aiFeatureProperties.getProvider() + "RequestBodyBuilder");

        if (builder == null) {
            throw new IllegalArgumentException("Unknown provider: " + aiFeatureProperties.getProvider() + ". Available providers: " + requestBodyBuilders.keySet());
        }

        return builder.buildRequestBodyForChatBot(instruction, message, aiFeatureProperties);
    }

}
