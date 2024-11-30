package com.hcmus.mela.lecture.exception.advice;

import com.hcmus.mela.lecture.controller.LectureController;
import com.hcmus.mela.lecture.controller.LevelController;
import com.hcmus.mela.lecture.controller.TopicController;
import com.hcmus.mela.lecture.exception.exception.AsyncException;
import com.hcmus.mela.lecture.exception.exception.LectureException;
import com.hcmus.mela.lecture.exception.response.ApiExceptionResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

@Slf4j
@RestControllerAdvice(basePackageClasses = {
        LevelController.class,
        TopicController.class,
        LectureController.class
})
public class MathContentControllerAdvice {

    @ExceptionHandler(LectureException.class)
    ResponseEntity<ApiExceptionResponse> handleMathContentException(LectureException exception) {

        final ApiExceptionResponse response = new ApiExceptionResponse(
                exception.getErrorMessage(),
                HttpStatus.BAD_REQUEST,
                LocalDateTime.now()
        );

        return ResponseEntity.status(response.getStatus()).body(response);
    }

    @ExceptionHandler(AsyncException.class)
    ResponseEntity<ApiExceptionResponse> handleAsyncException(AsyncException exception) {

        final ApiExceptionResponse response = new ApiExceptionResponse(
                exception.getMessage(),
                HttpStatus.INTERNAL_SERVER_ERROR,
                LocalDateTime.now()
        );
        log.info("Async exception thrown: {}", exception.getMessage());

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
