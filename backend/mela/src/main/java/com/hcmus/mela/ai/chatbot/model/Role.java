package com.hcmus.mela.ai.chatbot.model;

import lombok.Getter;

import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Getter
public enum Role {
    USER("user"),
    ASSISTANT("assistant");

    private static final Map<String, Role> ROLE_MAP =
            Stream.of(values()).collect(Collectors.toMap(r -> r.role.toLowerCase(), r -> r));

    private final String role;

    Role(String role) {
        this.role = role;
    }

    public static Role fromString(String role) {
        Role result = ROLE_MAP.get(role.toLowerCase());
        if (result != null) {
            return result;
        }
        throw new IllegalArgumentException(
                "Invalid role: '" + role + "'. Allowed values: " + ROLE_MAP.keySet()
        );
    }
}
