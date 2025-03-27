package com.hcmus.mela.ai.client;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.util.Map;

@Setter
@Getter
@Configuration
@ConfigurationProperties(prefix = "ai")
public class AiClientProperties {
    private Map<String, Provider> providers;
    private ChatBot chatBot;
    private QuestionHint questionHint;

    @Setter
    @Getter
    public static class Provider {
        private String baseUrl;
        private String key;
    }

    @Setter
    @Getter
    public static class ChatBot implements AiFeatureProperties{
        private String provider;
        private String model;
        private String path;
        private double temperature;
        private int maxCompletionTokens;
    }

    @Setter
    @Getter
    public static class QuestionHint implements AiFeatureProperties{
        private String provider;
        private String model;
        private String path;
        private double temperature;
        private int maxCompletionTokens;
    }

}
