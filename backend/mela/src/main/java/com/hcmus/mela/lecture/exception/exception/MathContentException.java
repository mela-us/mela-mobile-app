package com.hcmus.mela.lecture.exception.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class MathContentException extends RuntimeException {
    
    private final String errorMessage;
}
