package com.hcmus.mela.statistic.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class StatisticException extends RuntimeException {

    private final String errorMessage;
}
