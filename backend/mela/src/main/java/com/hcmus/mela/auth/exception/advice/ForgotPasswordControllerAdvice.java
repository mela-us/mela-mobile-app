package com.hcmus.mela.auth.exception.advice;

import com.hcmus.mela.auth.controller.ForgotPasswordController;
import com.hcmus.mela.auth.exception.exception.ForgotPasswordException;

import com.hcmus.mela.auth.exception.exception.InvalidTokenException;
import com.hcmus.mela.auth.exception.exception.UserNotFoundException;
import com.hcmus.mela.auth.exception.response.ApiExceptionResponse;
import jakarta.mail.MessagingException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

@RestControllerAdvice(basePackageClasses = ForgotPasswordController.class)
public class ForgotPasswordControllerAdvice {
    @ExceptionHandler(ForgotPasswordException.class)
    ResponseEntity<ApiExceptionResponse> handleForgotPasswordException(ForgotPasswordException exception) {

        final ApiExceptionResponse response = new ApiExceptionResponse(exception.getErrorMessage(), HttpStatus.BAD_REQUEST, LocalDateTime.now());

        return ResponseEntity.status(response.getStatus()).body(response);
    }
    @ExceptionHandler(UserNotFoundException.class)
    ResponseEntity<ApiExceptionResponse> handleUserNotFoundException(UserNotFoundException exception) {

        final ApiExceptionResponse response = new ApiExceptionResponse(exception.getErrorMessage(), HttpStatus.BAD_REQUEST, LocalDateTime.now());

        return ResponseEntity.status(response.getStatus()).body(response);
    }
    @ExceptionHandler(InvalidTokenException.class)
    ResponseEntity<ApiExceptionResponse> handleInvalidTokenException(InvalidTokenException exception) {

        final ApiExceptionResponse response = new ApiExceptionResponse(exception.getErrorMessage(), HttpStatus.UNAUTHORIZED, LocalDateTime.now());

        return ResponseEntity.status(response.getStatus()).body(response);
    }
}
