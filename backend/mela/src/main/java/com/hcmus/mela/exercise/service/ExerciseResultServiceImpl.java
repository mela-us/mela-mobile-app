package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.model.*;
import com.hcmus.mela.exercise.repository.ExerciseRepository;
import com.hcmus.mela.history.dto.dto.ExerciseAnswerDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExerciseResultServiceImpl implements ExerciseResultService {

    private final ExerciseRepository exerciseRepository;

    @Override
    public void checkResult(UUID exerciseId, List<ExerciseAnswerDto> exerciseAnswerDtoList) {
        Exercise exercise = exerciseRepository.findById(exerciseId).orElse(null);
        Map<UUID, Question> questionMap = new HashMap<>();
        if (exercise != null) {
            questionMap = exercise.getQuestions()
                    .stream()
                    .collect(Collectors.toMap(Question::getQuestionId, question -> question));
        }
        for (ExerciseAnswerDto exerciseAnswerDto : exerciseAnswerDtoList) {
            UUID questionId = exerciseAnswerDto.getQuestionId();

            Question question = questionMap.get(questionId);
            if (question == null) {
                exerciseAnswerDto.setIsCorrect(false);
                continue;
            }
            String blankAnswer = exerciseAnswerDto.getBlankAnswer();
            Integer selectedOption = exerciseAnswerDto.getSelectedOption();
            List<Option> options = question.getOptions();
            Integer correctOption = null;
            if (options != null && !options.isEmpty()) {
                correctOption = options
                        .stream()
                        .filter(Option::getIsCorrect)
                        .findFirst()
                        .map(Option::getOrdinalNumber)
                        .orElse(null);
            }
            exerciseAnswerDto.setIsCorrect(evalAnswer(question.getBlankAnswer(), blankAnswer, correctOption, selectedOption));
        }
    }

    private Boolean evalAnswer(String correctAnswer, String blankAnswer, Integer correctOption, Integer selectedOption) {
        if (correctOption != null && correctOption != 0) {
            return correctOption.equals(selectedOption);
        }
        if (correctAnswer != null) {
            return correctAnswer.equals(blankAnswer);
        }
        return false;
    }
}