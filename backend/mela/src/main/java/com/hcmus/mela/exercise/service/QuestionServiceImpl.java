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
    public Question findByQuestionId(Integer questionId) {
        return questionRepository.findByQuestionId(questionId);
    }

    @Override
    public List<Question> findAllQuestionsInExercise(Integer questionId) {
        return questionRepository.findAllByExerciseId(questionId);
    }

    @Override
    public QuestionResponse getQuestion(QuestionRequest questionRequest) {
        questionValidationService.validateQuestion(questionRequest);

        final Integer questionId = questionRequest.getQuestionId();

        Question question = findByQuestionId(questionId);

        QuestionDto questionDto = QuestionMapper.INSTANCE.convertToQuestionDto(question);

        final String questionSuccessMessage = generalMessageAccessor.getMessage(null, QUESTION_FOUND, questionId);

        log.info(questionSuccessMessage);

        return new QuestionResponse(questionSuccessMessage,List.of(questionDto));
    }

    @Override
    public QuestionResponse getAllQuestionsInExercise(QuestionRequest questionRequest) {
        questionValidationService.validateExercise(questionRequest);

        final Integer exerciseId = questionRequest.getExerciseId();

    List<Question> questions = findAllQuestionsInExercise(exerciseId);

    List<QuestionDto> questionDtos = new ArrayList<>();

        for(Question question: questions) {
            questionDtos.add(QuestionMapper.INSTANCE.convertToQuestionDto(question));
        }

        final String questionsSuccessMessage = generalMessageAccessor.getMessage(null, QUESTIONS_FOUND, exerciseId);

        log.info(questionsSuccessMessage);

        return new QuestionResponse(questionsSuccessMessage, questionDtos);
    }

    @Override
    public Integer getNumberOfQuestionsInExercise(Integer exerciseId) {

        List<Question> questions = findAllQuestionsInExercise(exerciseId);

        return questions.size();
    }


}
