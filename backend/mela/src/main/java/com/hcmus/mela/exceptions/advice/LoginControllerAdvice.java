package com.hcmus.mela.exceptions.advice;

import com.hcmus.mela.controller.LoginController;
import com.hcmus.mela.exceptions.response.ApiExceptionResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

@RestControllerAdvice(basePackageClasses = LoginController.class)
public class LoginControllerAdvice {
    @ExceptionHandler(BadCredentialsException.class)
    ResponseEntity<ApiExceptionResponse> handleRegistrationException(BadCredentialsException exception) {

        final ApiExceptionResponse response = new ApiExceptionResponse("Invalid username or password", HttpStatus.UNAUTHORIZED, LocalDateTime.now());

        return ResponseEntity.status(response.getStatus()).body(response);
    }

}
