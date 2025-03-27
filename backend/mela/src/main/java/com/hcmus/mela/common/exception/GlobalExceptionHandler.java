package com.hcmus.mela.common.exception;

import com.azure.core.exception.ResourceNotFoundException;
import com.hcmus.mela.auth.exception.JwtAuthenticationException;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    private String getRequestId() {
        String requestId = MDC.get("X-Request-Id");
        if (requestId == null) {
            requestId = UUID.randomUUID().toString();
        }
        return requestId;
    }

    @ExceptionHandler(JwtAuthenticationException.class)
    ResponseEntity<ApiErrorResponse> handleJwtAuthenticationException(JwtAuthenticationException ex, WebRequest request) {
        log.error("JWT Authentication error: {}", ex.getMessage());

        final ApiErrorResponse response = new ApiErrorResponse(
                getRequestId(),
                HttpStatus.UNAUTHORIZED.value(),
                ex.getMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );

        return ResponseEntity.status(response.getStatus()).body(response);
    }

    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ApiErrorResponse> handleAccessDeniedException(AccessDeniedException ex, WebRequest request) {
        log.warn("Access denied: {}", ex.getMessage());

        final ApiErrorResponse response = new ApiErrorResponse(
                getRequestId(),
                HttpStatus.FORBIDDEN.value(),
                "You do not have permission to access this resource.",
                request.getDescription(false),
                LocalDateTime.now()
        );

        return ResponseEntity.status(response.getStatus()).body(response);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ApiErrorResponse> handleMethodArgumentNotValidException(
            MethodArgumentNotValidException ex, WebRequest request) {

        List<String> errorList = ex.getBindingResult().getFieldErrors().stream()
                .map(FieldError::getDefaultMessage)
                .collect(Collectors.toList());

        log.warn("Validation failed: {}", errorList);

        final ApiErrorResponse apiErrorResponse = new ApiErrorResponse(
                getRequestId(),
                HttpStatus.BAD_REQUEST.value(),
                "Validation error",
                request.getDescription(false),
                LocalDateTime.now()
        );

        return ResponseEntity.status(apiErrorResponse.getStatus()).body(apiErrorResponse);
    }

    @ExceptionHandler(ConstraintViolationException.class)
    public ResponseEntity<ApiErrorResponse> handleConstraintViolationException(ConstraintViolationException ex, WebRequest request) {

        Set<ConstraintViolation<?>> violations = ex.getConstraintViolations();
        List<String> errorList = violations.stream()
                .map(ConstraintViolation::getMessage)
                .collect(Collectors.toList());

        log.warn("Constraint violation: {}", errorList);

        final ApiErrorResponse apiErrorResponse = new ApiErrorResponse(
                getRequestId(),
                HttpStatus.BAD_REQUEST.value(),
                "Constraint violation",
                request.getDescription(false),
                LocalDateTime.now()
        );

        return ResponseEntity.status(apiErrorResponse.getStatus()).body(apiErrorResponse);
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<ApiErrorResponse> handleHttpMessageNotReadableException(
            HttpMessageNotReadableException ex, WebRequest request) {
        log.warn("Malformed JSON request: {}", ex.getMessage());

        final ApiErrorResponse apiErrorResponse = new ApiErrorResponse(
                getRequestId(),
                HttpStatus.BAD_REQUEST.value(),
                "Request body is missing or malformed",
                request.getDescription(false),
                LocalDateTime.now()
        );

        return ResponseEntity.status(apiErrorResponse.getStatus()).body(apiErrorResponse);
    }

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ApiErrorResponse> handleResourceNotFoundException(ResourceNotFoundException ex, WebRequest request) {
        log.warn("Resource not found: {}", ex.getMessage());

        final ApiErrorResponse response = new ApiErrorResponse(
                getRequestId(),
                HttpStatus.NOT_FOUND.value(),
                ex.getMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );

        return ResponseEntity.status(response.getStatus()).body(response);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiErrorResponse> handleGlobalException(Exception ex, WebRequest request) {
        log.error("Unexpected error occurred: {}", ex.getMessage(), ex);

        final ApiErrorResponse response = new ApiErrorResponse(
                getRequestId(),
                HttpStatus.INTERNAL_SERVER_ERROR.value(),
                "An unexpected error occurred. Please try again later.",
                request.getDescription(false),
                LocalDateTime.now()
        );

        return ResponseEntity.status(response.getStatus()).body(response);
    }
}
