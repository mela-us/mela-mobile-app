package com.hcmus.mela.ai.client.builder;

import com.hcmus.mela.ai.client.AiFeatureProperties;
import com.hcmus.mela.ai.client.requestbody.openai.Message;
import com.hcmus.mela.ai.client.requestbody.openai.OpenAiRequestBody;
import org.springframework.stereotype.Component;
import java.util.List;

@Component
public class OpenaiRequestBodyBuilder implements AiRequestBodyBuilder {
    @Override
    public Object buildRequestBody(String instruction, String userMessage, AiFeatureProperties aiFeatureProperties) {

        return new OpenAiRequestBody(
                aiFeatureProperties.getModel(),
                List.of(new Message("system", instruction),
                        new Message("user", userMessage)),
                aiFeatureProperties.getTemperature(),
                aiFeatureProperties.getMaxCompletionTokens()
        );
    }
}
