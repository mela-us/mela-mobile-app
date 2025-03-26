package com.hcmus.mela.ai.client.builder;

import org.springframework.stereotype.Component;
import java.util.Map;

@Component
public class AiRequestBodyFactory {
    private final Map<String, AiRequestBodyBuilder> requestBodyBuilders;

    public AiRequestBodyFactory(Map<String, AiRequestBodyBuilder> requestBodyBuilders) {
        this.requestBodyBuilders = requestBodyBuilders;
    }

    public Object createRequestBody(String provider, String instruction, String userMessage, String model) {
        AiRequestBodyBuilder builder = requestBodyBuilders.get(provider.toLowerCase() + "RequestBodyBuilder");
        if (builder == null) {
            throw new IllegalArgumentException("Unknown provider: " + provider);
        }
        return builder.buildRequestBody(instruction, userMessage, model);
    }
}
