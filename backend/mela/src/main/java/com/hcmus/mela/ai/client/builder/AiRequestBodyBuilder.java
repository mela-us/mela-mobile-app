package com.hcmus.mela.ai.client.builder;

import com.hcmus.mela.ai.client.AiClientProperties;

public interface AiRequestBodyBuilder {
    Object buildRequestBody(String instruction, String userMessage, String model);
}
