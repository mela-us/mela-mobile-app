package com.hcmus.mela.exercise.exception.advice;

import com.hcmus.mela.exercise.controller.ExerciseController;
import com.hcmus.mela.exercise.exception.exception.ExerciseException;
import com.hcmus.mela.lecture.exception.response.ApiExceptionResponse;
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
