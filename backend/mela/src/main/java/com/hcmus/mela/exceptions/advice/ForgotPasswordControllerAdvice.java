package com.hcmus.mela.exceptions.advice;

import com.hcmus.mela.controller.ForgotPasswordController;
import com.hcmus.mela.exceptions.custom.ForgotPasswordException;
import com.hcmus.mela.exceptions.response.ApiExceptionResponse;
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

}
