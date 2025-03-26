package com.hcmus.mela.ai.client.builder;

import com.hcmus.mela.ai.client.request.openai.Message;
import com.hcmus.mela.ai.client.request.openai.OpenAiRequestBody;
import org.springframework.stereotype.Component;
import java.util.List;

@Component
public class OpenaiRequestBodyBuilder implements AiRequestBodyBuilder {
    @Override
    public Object buildRequestBody(String instruction, String userMessage, String model) {
        return new OpenAiRequestBody(
                model,
                List.of(new Message("system", instruction),
                        new Message("user", userMessage)),
                0.7,
                100
        );
    }
}
