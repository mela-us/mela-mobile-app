package com.hcmus.mela.exceptions.advice;

import com.hcmus.mela.controller.LectureController;
import com.hcmus.mela.controller.LevelController;
import com.hcmus.mela.controller.PracticeController;
import com.hcmus.mela.controller.TopicController;
import com.hcmus.mela.exceptions.custom.MathContentException;
import com.hcmus.mela.exceptions.response.ApiExceptionResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

@RestControllerAdvice(basePackageClasses = PracticeController.class)
public class PracticeControllerAdvice {
    @ExceptionHandler(MathContentException.class)
    ResponseEntity<ApiExceptionResponse> handlePracticeException(MathContentException exception) {

        final ApiExceptionResponse response = new ApiExceptionResponse(exception.getErrorMessage(), HttpStatus.BAD_REQUEST, LocalDateTime.now());

        return ResponseEntity.status(response.getStatus()).body(response);
    }

}
