package com.hcmus.mela.ai.chatbot.exception.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class ServiceUnavailableException extends RuntimeException {
    private final String errorMessage;
}
