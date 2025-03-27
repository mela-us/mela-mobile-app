package com.hcmus.mela.ai.client.builder;

import com.hcmus.mela.ai.client.AiFeatureProperties;

import java.util.List;
import java.util.Map;

/**
 * Interface for building request bodies for different AI providers.
 * Each AI provider implementation should provide its own implementation
 * of this interface to format requests according to the provider's API.
 */
public interface AiRequestBodyBuilder {
    /**
     * Builds a request body for the question hint feature.
     *
     * @param instruction System instruction for the AI
     * @param textData Text content of the question
     * @param imageUrls List of image URLs to include in the request
     * @param aiFeatureProperties Configuration properties for the AI feature
     * @return A request body object formatted for the specific AI provider
     */
    Object buildRequestBodyForQuestionHint(String instruction, String textData, List<String> imageUrls, AiFeatureProperties aiFeatureProperties);

    /**
     * Builds a request body for the chat bot feature.
     *
     * @param instruction System instruction for the AI
     * @param message List of message objects containing role and content
     * @param aiFeatureProperties Configuration properties for the AI feature
     * @return A request body object formatted for the specific AI provider
     */
    Object buildRequestBodyForChatBot(String instruction, List<Map<String, String>> message, AiFeatureProperties aiFeatureProperties);
}
