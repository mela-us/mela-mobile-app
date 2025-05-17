package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.model.Exercise;
import com.hcmus.mela.exercise.model.Question;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class QuestionServiceImpl implements QuestionService {

    private final ExerciseService exerciseService;

    @Override
    public Question findByQuestionId(UUID questionId) {

        Exercise exercise = exerciseService.findByQuestionId(questionId);
        if (exercise == null || exercise.getQuestions() == null) {
            return null;
        }

        return exercise.getQuestions().stream()
                .filter(q -> q.getQuestionId().equals(questionId))
                .findFirst()
                .orElse(null);
    }
}
