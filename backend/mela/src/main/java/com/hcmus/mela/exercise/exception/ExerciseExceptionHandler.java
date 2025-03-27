package com.hcmus.mela.exercise.exception;

import com.hcmus.mela.common.exception.ApiErrorResponse;
import com.hcmus.mela.exercise.controller.ExerciseController;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

import java.time.LocalDateTime;
import java.util.UUID;

@Slf4j
@RestControllerAdvice(basePackageClasses = ExerciseController.class)
public class ExerciseExceptionHandler {

    private String getRequestId() {
        String requestId = MDC.get("X-Request-Id");
        if (requestId == null) {
            requestId = UUID.randomUUID().toString();
        }
        return requestId;
    }

    @ExceptionHandler(ExerciseException.class)
    ResponseEntity<ApiErrorResponse> handleExerciseException(ExerciseException exerciseException, WebRequest request) {

        final ApiErrorResponse response = new ApiErrorResponse(
                getRequestId(),
                HttpStatus.BAD_REQUEST.value(),
                exerciseException.getMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );

        return ResponseEntity.status(response.getStatus()).body(response);
    }
}
