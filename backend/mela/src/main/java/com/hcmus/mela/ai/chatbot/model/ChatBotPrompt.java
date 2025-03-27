package com.hcmus.mela.ai.chatbot.model;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties; import org.springframework.stereotype.Component;

@Setter
@Getter
@Component
@ConfigurationProperties(prefix = "prompt.chatbot")
public class ChatBotPrompt {
    private IdentifyProblem identifyProblem;
    private ResolveConfusion resolveConfusion;
    private ReviewSubmission reviewSubmission;
    private ProvideSolution provideSolution;

    @Setter
    @Getter
    public static class IdentifyProblem {
        private String instruction;
    }

    @Setter
    @Getter
    public static class ResolveConfusion {
        private String instruction;
    }
    @Setter
    @Getter
    public static class ReviewSubmission {
        private String instruction;
    }
    @Setter
    @Getter
    public static class ProvideSolution {
        private String instruction;
    }

}