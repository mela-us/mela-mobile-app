package com.hcmus.mela.ai.chatbot.exception.advice;

import com.hcmus.mela.ai.chatbot.exception.exception.ChatBotException;
import com.hcmus.mela.ai.chatbot.exception.exception.ServiceUnavailableException;
import com.hcmus.mela.common.exception.ApiExceptionResponse;
import jakarta.xml.bind.ValidationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import java.time.LocalDateTime;

@ControllerAdvice
public class ChatBotControllerAdvice {

    @ExceptionHandler(ValidationException.class)
    public ResponseEntity<ApiExceptionResponse> handleValidationException(ValidationException ex, WebRequest request) {
        ApiExceptionResponse apiExceptionResponse = new ApiExceptionResponse(
                HttpStatus.BAD_REQUEST.value(),
                "Validation error",
                ex.getMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );
        return new ResponseEntity<>(apiExceptionResponse, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(ServiceUnavailableException.class)
    public ResponseEntity<ApiExceptionResponse> handleServiceUnavailableException(ServiceUnavailableException ex, WebRequest request) {
        ApiExceptionResponse apiExceptionResponse = new ApiExceptionResponse(
                HttpStatus.SERVICE_UNAVAILABLE.value(),
                "Service unavailable",
                ex.getMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );
        return new ResponseEntity<>(apiExceptionResponse, HttpStatus.SERVICE_UNAVAILABLE);
    }

    @ExceptionHandler(ChatBotException.class)
    public ResponseEntity<ApiExceptionResponse> handleChatBotException(ChatBotException ex, WebRequest request) {
        ApiExceptionResponse apiExceptionResponse = new ApiExceptionResponse(
                HttpStatus.INTERNAL_SERVER_ERROR.value(),
                "ChatBot error",
                ex.getMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );
        return new ResponseEntity<>(apiExceptionResponse, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiExceptionResponse> handleGenericException(Exception ex, WebRequest request) {
        ApiExceptionResponse apiExceptionResponse = new ApiExceptionResponse(
                HttpStatus.INTERNAL_SERVER_ERROR.value(),
                "Unexpected error",
                ex.getMessage(),
                request.getDescription(false),
                LocalDateTime.now()
        );
        return new ResponseEntity<>(apiExceptionResponse, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
