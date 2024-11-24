package com.hcmus.mela.exercise.controller;

import com.hcmus.mela.exercise.dto.request.QuestionRequest;
import com.hcmus.mela.exercise.dto.response.QuestionResponse;
import com.hcmus.mela.auth.security.utils.SecurityConstants;
import com.hcmus.mela.exercise.service.QuestionService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.AllArgsConstructor;
import org.apache.logging.log4j.util.Strings;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/api")
public class QuestionController {

    private final QuestionService questionService;

    @RequestMapping(value = "/exercises/{exerciseId}/questions", method = RequestMethod.GET)
    @Operation(tags = "Question Service", description = "You can find a list of questions belonging to an exercise " +
            "from the system by accessing the appropriate path.")
    public ResponseEntity<QuestionResponse> getQuestionInExercise(
            @PathVariable Integer exerciseId,
            @RequestHeader("Authorization") String authorizationHeader) {

        QuestionRequest questionRequest = new QuestionRequest(null, exerciseId);

        final QuestionResponse questionResponse = questionService.getAllQuestionsInExercise(questionRequest);

        String token = authorizationHeader.replace(SecurityConstants.TOKEN_PREFIX, Strings.EMPTY);

        return ResponseEntity.ok(questionResponse);
    }

    @RequestMapping(value = "/questions/{questionId}", method = RequestMethod.GET)
    @Operation(tags = "Question Service", description = "You can find a question from the system by accessing the " +
            "appropriate path.")
    public ResponseEntity<QuestionResponse> getQuestion(
            @PathVariable Integer questionId,
            @RequestHeader("Authorization") String authorizationHeader) {

        QuestionRequest questionRequest = new QuestionRequest(questionId, null);

        final QuestionResponse questionResponse = questionService.getQuestion(questionRequest);

        String token = authorizationHeader.replace(SecurityConstants.TOKEN_PREFIX, Strings.EMPTY);

        return ResponseEntity.ok(questionResponse);
    }
}
