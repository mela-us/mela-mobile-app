package com.hcmus.mela.ai.client.builder;

import com.hcmus.mela.ai.client.AiFeatureProperties;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public class AiRequestBodyFactory {
    private final Map<String, AiRequestBodyBuilder> requestBodyBuilders;

    public AiRequestBodyFactory(Map<String, AiRequestBodyBuilder> requestBodyBuilders) {
        this.requestBodyBuilders = requestBodyBuilders;
    }

    public Object createRequestBodyForQuestionHint(String instruction, String message, AiFeatureProperties aiFeatureProperties) {
        AiRequestBodyBuilder builder = requestBodyBuilders.get(aiFeatureProperties.getProvider() + "RequestBodyBuilder");

        if (builder == null) {
            throw new IllegalArgumentException("Unknown provider: " + aiFeatureProperties.getProvider() + ". Available providers: " + requestBodyBuilders.keySet());
        }

        return builder.buildRequestBodyForQuesionHint(instruction, message, aiFeatureProperties);
    }

    public Object createRequestBodyForChatBot(String instruction, List<Map<String, String>> message, AiFeatureProperties aiFeatureProperties) {
        AiRequestBodyBuilder builder = requestBodyBuilders.get(aiFeatureProperties.getProvider() + "RequestBodyBuilder");

        if (builder == null) {
            throw new IllegalArgumentException("Unknown provider: " + aiFeatureProperties.getProvider() + ". Available providers: " + requestBodyBuilders.keySet());
        }

        return builder.buildRequestBodyForChatBot(instruction, message, aiFeatureProperties);
    }

}
