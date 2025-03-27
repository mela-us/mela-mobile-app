package com.hcmus.mela.lecture.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class LectureException extends RuntimeException {
    
    private final String errorMessage;
}
