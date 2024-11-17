package com.hcmus.mela.exceptions.advice;

import com.hcmus.mela.controller.ExerciseController;
import com.hcmus.mela.exceptions.custom.ExerciseException;
import com.hcmus.mela.exceptions.response.ApiExceptionResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

@RestControllerAdvice(basePackageClasses = ExerciseController.class)
public class ExerciseAdvice {

    @ExceptionHandler(ExerciseException.class)
    ResponseEntity<ApiExceptionResponse> handleExerciseException(ExerciseException exerciseException) {
        final ApiExceptionResponse response = new ApiExceptionResponse(exerciseException.getErrorMessage(), HttpStatus.BAD_REQUEST, LocalDateTime.now());

        return ResponseEntity.status(response.getStatus()).body(response);
    }
}
