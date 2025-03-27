package com.hcmus.mela.history.exception.advice;

import com.hcmus.mela.history.exception.exception.AsyncException;
import com.hcmus.mela.history.exception.exception.HistoryException;
import com.hcmus.mela.history.exception.response.ApiExceptionResponse;
import com.hcmus.mela.statistic.controller.StatisticController;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

@Slf4j
@RestControllerAdvice(basePackageClasses = StatisticController.class)
public class HistoryControllerAdvice {

    @ExceptionHandler(HistoryException.class)
    ResponseEntity<ApiExceptionResponse> handleMathContentException(HistoryException exception) {
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
        log.error("Exception stack trace: ", exception);
        log.info("Unexpected exception thrown: {}", exception.getMessage());

        return ResponseEntity.status(response.getStatus()).body(response);
    }
}
