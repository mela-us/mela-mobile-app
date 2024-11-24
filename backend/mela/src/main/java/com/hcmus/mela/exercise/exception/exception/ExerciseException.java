package com.hcmus.mela.exercise.exception.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class ExerciseException extends RuntimeException {
    private final String errorMessage;
}
