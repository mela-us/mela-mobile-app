package com.hcmus.mela.ai.client.builder;

import com.hcmus.mela.ai.client.AiClientProperties;
import com.hcmus.mela.ai.client.AiFeatureProperties;
import org.springframework.stereotype.Component;
import java.util.Map;

@Component
public class AiRequestBodyFactory {
    private final Map<String, AiRequestBodyBuilder> requestBodyBuilders;

    public AiRequestBodyFactory(Map<String, AiRequestBodyBuilder> requestBodyBuilders) {
        this.requestBodyBuilders = requestBodyBuilders;
    }

    public Object createRequestBody(String instruction, String userMessage, AiFeatureProperties aiFeatureProperties) {
        AiRequestBodyBuilder builder = requestBodyBuilders.get(aiFeatureProperties.getProvider() + "RequestBodyBuilder");

        if (builder == null) {
            throw new IllegalArgumentException("Unknown provider: " + aiFeatureProperties.getProvider() + ". Available providers: " + requestBodyBuilders.keySet());
        }

        return builder.buildRequestBody(instruction, userMessage, aiFeatureProperties);
    }

}
