package com.hcmus.mela.statistic.exception.advice;

import com.hcmus.mela.lecture.exception.exception.AsyncException;
import com.hcmus.mela.statistic.controller.StatisticController;
import com.hcmus.mela.statistic.exception.exception.StatisticException;
import com.hcmus.mela.statistic.exception.response.ApiExceptionResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

@Slf4j
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

    @ExceptionHandler(AsyncException.class)
    ResponseEntity<ApiExceptionResponse> handleAsyncException(AsyncException exception) {

        final ApiExceptionResponse response = new ApiExceptionResponse(
                exception.getMessage(),
                HttpStatus.INTERNAL_SERVER_ERROR,
                LocalDateTime.now()
        );
        log.info("Async exception thrown: {}", exception.getMessage());

        return ResponseEntity.status(response.getStatus()).body(response);
    }

    @ExceptionHandler(RuntimeException.class)
    ResponseEntity<ApiExceptionResponse> handleRuntimeException(RuntimeException exception) {

        final ApiExceptionResponse response = new ApiExceptionResponse(
                exception.getMessage(),
                HttpStatus.INTERNAL_SERVER_ERROR,
                LocalDateTime.now()
        );
        log.info("Unexpected exception thrown: {}", exception.getMessage());

        return ResponseEntity.status(response.getStatus()).body(response);
    }
}
