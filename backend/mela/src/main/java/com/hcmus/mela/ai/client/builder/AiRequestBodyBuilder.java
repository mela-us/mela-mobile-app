package com.hcmus.mela.ai.client.builder;

import com.hcmus.mela.ai.client.AiFeatureProperties;

public interface AiRequestBodyBuilder {
    Object buildRequestBody(String instruction, String userMessage, AiFeatureProperties aiFeatureProperties);
}
