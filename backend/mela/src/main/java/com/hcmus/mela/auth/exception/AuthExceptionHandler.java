package com.hcmus.mela.auth.exception;

import com.hcmus.mela.auth.controller.AuthController;
import com.hcmus.mela.auth.controller.ForgotPasswordController;
import com.hcmus.mela.common.exception.ApiErrorResponse;
import org.slf4j.MDC;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

import java.time.LocalDateTime;
import java.util.UUID;

@Order(Ordered.HIGHEST_PRECEDENCE)
@RestControllerAdvice(basePackageClasses = {
        AuthController.class,
        ForgotPasswordController.class
})
public class AuthExceptionHandler {

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
            HttpStatus.BAD_REQUEST.value(),
            exception.getMessage(),
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
                exception.getMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );
        return ResponseEntity.status(response.getStatus()).body(response);
    }

    @ExceptionHandler(RegistrationException.class)
    ResponseEntity<ApiErrorResponse> handleLoginException(RegistrationException exception, WebRequest request) {

        final ApiErrorResponse response = new ApiErrorResponse(
                getRequestId(),
                HttpStatus.BAD_REQUEST.value(),
                exception.getMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );
        return ResponseEntity.status(response.getStatus()).body(response);
    }

    @ExceptionHandler(BadCredentialsException.class)
    ResponseEntity<ApiErrorResponse> handleLoginException(BadCredentialsException exception, WebRequest request) {

        final ApiErrorResponse response = new ApiErrorResponse(
                getRequestId(),
                HttpStatus.BAD_REQUEST.value(),
                "Invalid username or password",
                request.getDescription(false),
                LocalDateTime.now()
        );
        return ResponseEntity.status(response.getStatus()).body(response);
    }

    @ExceptionHandler(ForgotPasswordException.class)
    ResponseEntity<ApiErrorResponse> handleForgotPasswordException(ForgotPasswordException exception, WebRequest request) {

        final ApiErrorResponse response = new ApiErrorResponse(
                getRequestId(),
                HttpStatus.BAD_REQUEST.value(),
                exception.getMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );
        return ResponseEntity.status(response.getStatus()).body(response);
    }
}
