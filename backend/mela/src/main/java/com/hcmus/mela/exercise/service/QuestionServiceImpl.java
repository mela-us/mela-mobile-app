package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.dto.request.QuestionRequest;
import com.hcmus.mela.exercise.dto.response.QuestionResponse;
import com.hcmus.mela.exercise.dto.dto.QuestionDto;
import com.hcmus.mela.exercise.model.Question;

import com.hcmus.mela.exercise.repository.QuestionRepository;
import com.hcmus.mela.exercise.mapper.QuestionMapper;
import com.hcmus.mela.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class QuestionServiceImpl implements QuestionService {

    private static final String QUESTION_FOUND = "question_found_successful";
    private static final String QUESTIONS_FOUND = "questions_of_lecture_found_successful";
    private final QuestionRepository questionRepository;
    private final QuestionValidationService questionValidationService;
    private final GeneralMessageAccessor generalMessageAccessor;

    @Override
    public Question findByQuestionId(UUID questionId) {

        return questionRepository.findByQuestionId(questionId);
    }

}
