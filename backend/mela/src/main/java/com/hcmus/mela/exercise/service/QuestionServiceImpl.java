package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.model.Exercise;
import com.hcmus.mela.exercise.model.Question;

import com.hcmus.mela.common.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class QuestionServiceImpl implements QuestionService {

    private static final String QUESTION_FOUND = "question_found_successful";
    private static final String QUESTIONS_FOUND = "questions_of_lecture_found_successful";
    private final ExerciseService exerciseService;
    private final GeneralMessageAccessor generalMessageAccessor;

    @Override
    public Question findByQuestionId(UUID questionId) {

        Exercise exercise = exerciseService.findByQuestionId(questionId);

        for (Question question : exercise.getQuestions()) {
            if (question.getQuestionId().equals(questionId)) {
                return question;
            }
        }

        return null;
    }
}
