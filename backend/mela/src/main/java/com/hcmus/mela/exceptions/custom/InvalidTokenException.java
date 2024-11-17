package com.hcmus.mela.exceptions.custom;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class InvalidTokenException extends RuntimeException {
    private final String errorMessage;
}
