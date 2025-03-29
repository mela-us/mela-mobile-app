package com.hcmus.mela.ai.question.hint.exception;

import com.hcmus.mela.ai.question.hint.controller.QuestionHintController;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Order(Ordered.HIGHEST_PRECEDENCE)
@RestControllerAdvice(basePackageClasses = QuestionHintController.class)
public class QuestionHintExceptionHandler {
}
