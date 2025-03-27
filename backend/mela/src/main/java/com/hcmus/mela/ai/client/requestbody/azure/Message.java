package com.hcmus.mela.ai.client.requestbody.azure;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Map;

@Getter
@Setter
@AllArgsConstructor
public class Message {
    private String role;
    private Object content;
}
