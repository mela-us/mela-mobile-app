package com.hcmus.mela.lecture.exception.advice;

import com.hcmus.mela.lecture.controller.LectureController;
import com.hcmus.mela.lecture.controller.LevelController;
import com.hcmus.mela.lecture.controller.TopicController;
import com.hcmus.mela.lecture.exception.exception.MathContentException;
import com.hcmus.mela.lecture.exception.response.ApiExceptionResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

@RestControllerAdvice(basePackageClasses = {
        LevelController.class,
        TopicController.class,
        LectureController.class
})
public class MathContentControllerAdvice {

    @ExceptionHandler(MathContentException.class)
    ResponseEntity<ApiExceptionResponse> handleMathContentException(MathContentException exception) {

        final ApiExceptionResponse response = new ApiExceptionResponse(
                exception.getErrorMessage(),
                HttpStatus.BAD_REQUEST,
                LocalDateTime.now()
        );

        return ResponseEntity.status(response.getStatus()).body(response);
    }
}
