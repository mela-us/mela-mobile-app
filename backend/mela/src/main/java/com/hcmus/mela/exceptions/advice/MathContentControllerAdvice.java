package com.hcmus.mela.exceptions.advice;

import com.hcmus.mela.controller.ForgotPasswordController;
import com.hcmus.mela.controller.LectureController;
import com.hcmus.mela.controller.LevelController;
import com.hcmus.mela.controller.TopicController;
import com.hcmus.mela.exceptions.custom.ForgotPasswordException;
import com.hcmus.mela.exceptions.custom.MathContentException;
import com.hcmus.mela.exceptions.response.ApiExceptionResponse;
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

        final ApiExceptionResponse response = new ApiExceptionResponse(exception.getErrorMessage(), HttpStatus.BAD_REQUEST, LocalDateTime.now());

        return ResponseEntity.status(response.getStatus()).body(response);
    }

}
