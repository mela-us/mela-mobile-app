package com.hcmus.mela.ai.client.builder;


import com.hcmus.mela.ai.client.config.AiFeatureProperties;
import com.hcmus.mela.ai.client.dto.request.azure.AzureRequestBody;
import com.hcmus.mela.ai.client.dto.request.azure.Message;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Azure-specific implementation of AiRequestBodyBuilder.
 * Formats requests according to the Azure OpenAI API specifications.
 */
@Component
public class AzureRequestBodyBuilder implements AiRequestBodyBuilder {

    /**
     * Builds a request body for the question hint feature using Azure's format.
     * This method constructs a request with text and image content for multimodal models.
     *
     * @param instruction System instruction for the AI
     * @param textData Text content of the question
     * @param imageUrls List of image URLs to include in the request
     * @param aiFeatureProperties Configuration properties for the AI feature
     * @return An AzureRequestBody object with the formatted request
     */
    @Override
    public AzureRequestBody buildRequestBodyForQuestionHint(String instruction, String textData, List<String> imageUrls, AiFeatureProperties aiFeatureProperties) {
        List<Map<String, Object>> contentList = new ArrayList<>();

        // Add text content if provided
        if (textData != null && !textData.isBlank()) {
            contentList.add(Map.of("type", "text", "text", textData));
        }

        // Add image URLs if provided
        if (imageUrls != null && !imageUrls.isEmpty()) {
            for (String imageUrl : imageUrls) {
                if (imageUrl != null && !imageUrl.isBlank()) {
                    contentList.add(Map.of("type", "image_url", "image_url", Map.of("url", imageUrl.trim())));
                }
            }
        }

        // Create the full request body with system instruction and user content
        return new AzureRequestBody(
                aiFeatureProperties.getModel(),
                List.of(
                        new Message("system", instruction),
                        new Message("user", contentList)
                ),
                aiFeatureProperties.getTemperature(),
                aiFeatureProperties.getMaxCompletionTokens()
        );
    }

    /**
     * Builds a request body for the chatbot feature using Azure's format.
     * Note: This method is not yet implemented.
     *
     * @param instruction System instruction for the AI
     * @param message List of message objects containing role and content
     * @param aiFeatureProperties Configuration properties for the AI feature
     * @return null (not implemented)
     */
    @Override
    public Object buildRequestBodyForChatBot(String instruction, List<Map<String, String>> message, AiFeatureProperties aiFeatureProperties) {
        return null;
    }
}
