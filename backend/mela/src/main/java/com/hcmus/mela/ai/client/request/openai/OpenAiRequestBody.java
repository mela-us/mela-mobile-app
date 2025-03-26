package com.hcmus.mela.ai.client.request.openai;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class OpenAiRequestBody {
    private String model;
    private List<Message> messages;
    private double temperature;
    private int max_tokens;
}
