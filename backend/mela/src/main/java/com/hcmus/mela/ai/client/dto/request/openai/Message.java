package com.hcmus.mela.ai.client.dto.request.openai;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class Message {
    private String role;
    private Object content;
}
