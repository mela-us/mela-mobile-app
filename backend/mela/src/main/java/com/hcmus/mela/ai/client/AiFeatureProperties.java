package com.hcmus.mela.ai.client;

public interface AiFeatureProperties {
    String getModel();
    String getProvider();
    String getPath();
    double getTemperature();
    int getMaxCompletionTokens();
}
