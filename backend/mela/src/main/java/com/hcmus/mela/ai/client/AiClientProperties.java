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
    private ExerciseHint exerciseHint;
    private ExerciseGrading exerciseGrading;

    @Setter
    @Getter
    public static class Provider {
        private String baseUrl;
        private String key;
    }

    @Setter
    @Getter
    public static class ChatBot {
        private String provider;
        private String model;
        private String path;
    }

    @Setter
    @Getter
    public static class ExerciseHint {
        private String provider;
        private String model;
        private String path;
    }

    @Setter
    @Getter
    public static class ExerciseGrading {
        private String provider;
        private String model;
        private String path;
    }
}
