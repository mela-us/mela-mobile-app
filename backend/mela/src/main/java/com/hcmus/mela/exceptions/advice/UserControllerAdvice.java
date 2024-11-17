package com.hcmus.mela.exceptions.advice;

import com.hcmus.mela.controller.UserController;
import com.hcmus.mela.exceptions.custom.InvalidTokenException;
import com.hcmus.mela.exceptions.custom.UserNotFoundException;
import com.hcmus.mela.exceptions.response.ApiExceptionResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

@RestControllerAdvice(basePackageClasses = UserController.class)
public class UserControllerAdvice {
    @ExceptionHandler(UserNotFoundException.class)
    ResponseEntity<ApiExceptionResponse> handleUserNotFoundException(UserNotFoundException exception) {

        final ApiExceptionResponse response = new ApiExceptionResponse(exception.getErrorMessage(), HttpStatus.BAD_REQUEST, LocalDateTime.now());

        return ResponseEntity.status(response.getStatus()).body(response);
    }

    @ExceptionHandler(InvalidTokenException.class)
    ResponseEntity<ApiExceptionResponse> handleInvalidTokenException(InvalidTokenException exception) {

        final ApiExceptionResponse response = new ApiExceptionResponse(exception.getMessage(), HttpStatus.UNAUTHORIZED, LocalDateTime.now());

        return ResponseEntity.status(response.getStatus()).body(response);
    }
}
