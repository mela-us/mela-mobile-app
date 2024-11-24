package com.hcmus.mela.auth.exception.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class ForgotPasswordException extends RuntimeException {
    private final String errorMessage;
}
