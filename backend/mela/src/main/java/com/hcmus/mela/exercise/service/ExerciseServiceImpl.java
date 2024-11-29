package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.dto.dto.ExerciseResultDto;
import com.hcmus.mela.exercise.dto.dto.QuestionDto;
import com.hcmus.mela.exercise.dto.request.ExerciseRequest;
import com.hcmus.mela.exercise.dto.response.ExerciseResponse;
import com.hcmus.mela.exercise.dto.dto.ExerciseDto;
import com.hcmus.mela.exercise.dto.response.QuestionResponse;
import com.hcmus.mela.exercise.mapper.QuestionMapper;
import com.hcmus.mela.exercise.model.Exercise;
import com.hcmus.mela.exercise.model.Question;
import com.hcmus.mela.exercise.repository.ExerciseRepository;
import com.hcmus.mela.exercise.mapper.ExerciseMapper;
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
public class ExerciseServiceImpl implements ExerciseService {

    private static final String EXERCISE_FOUND = "exercise_found_successful";
    private static final String EXERCISES_FOUND = "exercises_of_lecture_found_successful";
    private final ExerciseRepository exerciseRepository;
    private final ExerciseValidationService exerciseValidationService;
    private final GeneralMessageAccessor generalMessageAccessor;
    private final ExerciseResultService exerciseResultService;

    @Override
    public Exercise findByExerciseId(UUID exerciseId) {

        return exerciseRepository.findByExerciseId(exerciseId);
    }

    @Override
    public List<Exercise> findAllExercisesInLecture(UUID lectureId) {
        return exerciseRepository.findAllByLectureId(lectureId);
    }

    @Override
    public QuestionResponse getExercise(ExerciseRequest exerciseRequest) {
        exerciseValidationService.validateExercise(exerciseRequest);

        final UUID exerciseId = exerciseRequest.getExerciseId();
        final UUID userId = exerciseRequest.getUserId();

        Exercise exercise = findByExerciseId(exerciseId);

        List<Question> questions = exercise.getQuestions();
        Integer numberOfQuestions = questions.size();

        List<QuestionDto> questionDtos = new ArrayList<>();

        for(Question question: questions) {

           QuestionDto questionDto = QuestionMapper.INSTANCE.convertToQuestionDto(question);

            questionDtos.add(questionDto);
        }

        
        final String exerciseSuccessMessage = generalMessageAccessor.getMessage(null, EXERCISE_FOUND, exerciseId);

        log.info(exerciseSuccessMessage);

        return new QuestionResponse(exerciseSuccessMessage, numberOfQuestions, questionDtos);
    }

    @Override
    public ExerciseResponse getAllExercisesInLecture(ExerciseRequest exerciseRequest) {
        exerciseValidationService.validateLecture(exerciseRequest);

        final UUID lectureId = exerciseRequest.getLectureId();

        List<Exercise> exercises = findAllExercisesInLecture(lectureId);

        List<ExerciseDto> exerciseDtos = new ArrayList<>();

        for(Exercise exercise: exercises) {
            final UUID exerciseId = exercise.getExerciseId();
            final UUID userId = exerciseRequest.getUserId();

            final Integer numberOfQuestions = exercise.getQuestions().size();

            ExerciseDto exerciseDto = ExerciseMapper.INSTANCE.convertToExerciseDto(exercise);
            ExerciseResultDto exerciseResultDto = exerciseResultService.getBestExerciseResult(userId, exerciseId);

            exerciseDto.setTotalQuestions(numberOfQuestions);
            exerciseDto.setBestResult(exerciseResultDto);

            exerciseDtos.add(exerciseDto);
        }

        final String exercisesSuccessMessage = generalMessageAccessor.getMessage(null, EXERCISES_FOUND, lectureId);

        log.info(exercisesSuccessMessage);

        return new ExerciseResponse(exercisesSuccessMessage,exerciseDtos.size(), exerciseDtos);
    }

    @Override
    public Integer getNumberOfQuestions(UUID exerciseId) {
        Exercise exercise = findByExerciseId(exerciseId);

        List<Question> questions = exercise.getQuestions();

        return questions.size();
    }
}
