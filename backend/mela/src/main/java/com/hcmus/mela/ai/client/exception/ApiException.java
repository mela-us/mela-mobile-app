package com.hcmus.mela.ai.client.exception;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ApiException extends RuntimeException {
    private final int statusCode;
    private final String errorMessage;
    public ApiException(int statusCode, String errorMessage) {
        super("API Error: " + errorMessage);
        this.statusCode = statusCode;
        this.errorMessage = errorMessage;
    }
}
