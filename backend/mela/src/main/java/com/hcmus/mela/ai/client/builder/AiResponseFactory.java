package com.hcmus.mela.ai.client.builder;


import com.hcmus.mela.ai.client.responsebody.azure.AzureResponseBody;
import com.hcmus.mela.ai.client.responsebody.openai.OpenAiResponseBody;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class AiResponseFactory {
    private final Map<String, Class<?>> responseTypes = Map.of(
            "azure", AzureResponseBody.class,
            "openai", OpenAiResponseBody.class
    );

    public Class<?> getResponseType(String provider) {
        return responseTypes.getOrDefault(provider.toLowerCase(), OpenAiResponseBody.class);
    }
}