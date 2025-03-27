package com.hcmus.mela.ai.client.builder;

import com.hcmus.mela.ai.client.AiFeatureProperties;

import java.util.List;
import java.util.Map;

public interface AiRequestBodyBuilder {
    Object buildRequestBodyForQuesionHint(String instruction, String message, AiFeatureProperties aiFeatureProperties);

    Object buildRequestBodyForChatBot(String instruction, List<Map<String, String>> message, AiFeatureProperties aiFeatureProperties);
}
