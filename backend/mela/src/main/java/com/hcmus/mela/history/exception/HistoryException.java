package com.hcmus.mela.history.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class HistoryException extends RuntimeException {

    private final String errorMessage;
}
