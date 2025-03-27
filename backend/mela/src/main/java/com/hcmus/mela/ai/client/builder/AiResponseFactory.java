package com.hcmus.mela.ai.client.builder;


import com.hcmus.mela.ai.client.responsebody.azure.AzureResponseBody;
import com.hcmus.mela.ai.client.responsebody.openai.OpenAiResponseBody;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * Factory for determining the appropriate response class type based on the AI provider.
 * This class maps provider names to their corresponding response body classes.
 */
@Component
public class AiResponseFactory {
    /**
     * Map of AI providers to their corresponding response body classes.
     * Keys are provider names in lowercase, values are the response body classes.
     */
    private final Map<String, Class<?>> responseTypes = Map.of(
            "azure", AzureResponseBody.class,
            "openai", OpenAiResponseBody.class
    );

    /**
     * Gets the appropriate response type class for the given provider.
     *
     * @param provider The name of the AI provider
     * @return The class type for the provider's response, or OpenAiResponseBody if not found
     */
    public Class<?> getResponseType(String provider) {
        return responseTypes.getOrDefault(provider.toLowerCase(), OpenAiResponseBody.class);
    }
}