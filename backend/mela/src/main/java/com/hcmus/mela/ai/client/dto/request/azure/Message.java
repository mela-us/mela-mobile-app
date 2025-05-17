package com.hcmus.mela.ai.client.dto.request.azure;

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
