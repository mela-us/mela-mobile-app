package com.hcmus.mela.exercise.exception.advice;

import com.hcmus.mela.exercise.controller.ExerciseController;
import com.hcmus.mela.exercise.exception.exception.ExerciseException;
import com.hcmus.mela.lecture.exception.response.ApiExceptionResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

@Slf4j
@RestControllerAdvice(basePackageClasses = ExerciseController.class)
public class ExerciseAdvice {

    @ExceptionHandler(ExerciseException.class)
    ResponseEntity<ApiExceptionResponse> handleExerciseException(ExerciseException exerciseException) {
        final ApiExceptionResponse response = new ApiExceptionResponse(exerciseException.getErrorMessage(), HttpStatus.BAD_REQUEST, LocalDateTime.now());

        return ResponseEntity.status(response.getStatus()).body(response);
    }

    @ExceptionHandler(RuntimeException.class)
    ResponseEntity<ApiExceptionResponse> handleRuntimeException(RuntimeException exception) {

        final ApiExceptionResponse response = new ApiExceptionResponse(
                exception.getMessage(),
                HttpStatus.INTERNAL_SERVER_ERROR,
                LocalDateTime.now()
        );
        log.info("Unexpected exception thrown: {}", exception.getMessage());

        return ResponseEntity.status(response.getStatus()).body(response);
    }
}
