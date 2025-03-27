package com.hcmus.mela.ai.client.builder;

import com.hcmus.mela.ai.client.AiFeatureProperties;
import com.hcmus.mela.ai.client.requestbody.openai.Message;
import com.hcmus.mela.ai.client.requestbody.openai.OpenAiRequestBody;
import org.springframework.stereotype.Component;
import java.util.List;
import java.util.Map;

@Component
public class OpenaiRequestBodyBuilder implements AiRequestBodyBuilder {


    @Override
    public Object buildRequestBodyForQuesionHint(String instruction, String message, AiFeatureProperties aiFeatureProperties) {
        return new OpenAiRequestBody(
                aiFeatureProperties.getModel(),
                List.of(new Message("system", instruction),
                        new Message("user", message)),
                aiFeatureProperties.getTemperature(),
                aiFeatureProperties.getMaxCompletionTokens()
        );
    }

    @Override
    public Object buildRequestBodyForChatBot(String instruction, List<Map<String, String>> message, AiFeatureProperties aiFeatureProperties) {
        return null;
    }
}
