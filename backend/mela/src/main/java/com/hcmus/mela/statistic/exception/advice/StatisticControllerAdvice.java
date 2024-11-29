package com.hcmus.mela.statistic.exception.advice;

import com.hcmus.mela.statistic.controller.StatisticController;
import com.hcmus.mela.statistic.exception.exception.StatisticException;
import com.hcmus.mela.statistic.exception.response.ApiExceptionResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

@RestControllerAdvice(basePackageClasses = StatisticController.class)
public class StatisticControllerAdvice {

    @ExceptionHandler(StatisticException.class)
    ResponseEntity<ApiExceptionResponse> handleMathContentException(StatisticException exception) {
        final ApiExceptionResponse response = new ApiExceptionResponse(
                exception.getErrorMessage(),
                HttpStatus.BAD_REQUEST,
                LocalDateTime.now()
        );
        return ResponseEntity.status(response.getStatus()).body(response);
    }
}
