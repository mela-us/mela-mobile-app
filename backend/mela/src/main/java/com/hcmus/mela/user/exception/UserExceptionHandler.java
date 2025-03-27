package com.hcmus.mela.user.exception;

import com.hcmus.mela.common.exception.ApiErrorResponse;
import com.hcmus.mela.user.controller.UserController;
import org.slf4j.MDC;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

import java.time.LocalDateTime;
import java.util.UUID;

@RestControllerAdvice(basePackageClasses = UserController.class)
public class UserExceptionHandler {

    private String getRequestId() {
        String requestId = MDC.get("X-Request-Id");
        if (requestId == null) {
            requestId = UUID.randomUUID().toString();
        }
        return requestId;
    }

    @ExceptionHandler(UserNotFoundException.class)
    ResponseEntity<ApiErrorResponse> handleUserNotFoundException(UserNotFoundException exception, WebRequest request) {

        final ApiErrorResponse response = new ApiErrorResponse(
                getRequestId(),
                HttpStatus.NOT_FOUND.value(),
                exception.getErrorMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );

        return ResponseEntity.status(response.getStatus()).body(response);
    }

    @ExceptionHandler(InvalidTokenException.class)
    ResponseEntity<ApiErrorResponse> handleInvalidTokenException(InvalidTokenException exception, WebRequest request) {

        final ApiErrorResponse response = new ApiErrorResponse(
                getRequestId(),
                HttpStatus.UNAUTHORIZED.value(),
                exception.getErrorMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );

        return ResponseEntity.status(response.getStatus()).body(response);
    }


    @ExceptionHandler(EmptyUpdateDataException.class)
    ResponseEntity<ApiErrorResponse> handleEmptyUpdateDataException(EmptyUpdateDataException exception, WebRequest request) {

        final ApiErrorResponse response = new ApiErrorResponse(
                getRequestId(),
                HttpStatus.BAD_REQUEST.value(),
                exception.getErrorMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );

        return ResponseEntity.status(response.getStatus()).body(response);
    }


}
