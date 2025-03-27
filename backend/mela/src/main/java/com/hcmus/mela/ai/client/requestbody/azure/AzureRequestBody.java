package com.hcmus.mela.ai.client.requestbody.azure;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class AzureRequestBody {
    private String model;
    private List<Message> messages;
    private double temperature;
    private int max_completion_tokens;
}
