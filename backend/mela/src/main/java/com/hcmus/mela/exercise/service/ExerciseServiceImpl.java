package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.dto.dto.ExerciseDto;
import com.hcmus.mela.exercise.dto.dto.ExerciseStatDetailDto;
import com.hcmus.mela.exercise.dto.dto.ExerciseResultDto;
import com.hcmus.mela.exercise.dto.dto.QuestionDto;
import com.hcmus.mela.exercise.dto.request.ExerciseRequest;
import com.hcmus.mela.exercise.dto.response.ExerciseResponse;
import com.hcmus.mela.exercise.dto.response.QuestionResponse;
import com.hcmus.mela.common.utils.GeneralMessageAccessor;
import com.hcmus.mela.exercise.mapper.ExerciseStatDetailMapper;
import com.hcmus.mela.exercise.model.Exercise;
import com.hcmus.mela.exercise.repository.ExerciseRepository;
import com.hcmus.mela.history.service.ExerciseHistoryService;
import com.hcmus.mela.lecture.dto.dto.LectureDto;
import com.hcmus.mela.lecture.service.LectureService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExerciseServiceImpl implements ExerciseService {

    private static final String EXERCISE_FOUND = "exercise_found_successful";

    private static final String EXERCISES_FOUND = "exercises_of_lecture_found_successful";

    private final GeneralMessageAccessor generalMessageAccessor;

    private final ExerciseRepository exerciseRepository;

    private final ExerciseValidationService exerciseValidationService;

    private final LectureService lectureService;

    private final ExerciseInfoService exerciseInfoService;

    private final ExerciseHistoryService exerciseHistoryService;

    @Override
    public QuestionResponse getExercise(ExerciseRequest exerciseRequest) {
        exerciseValidationService.validateExercise(exerciseRequest);

        final UUID exerciseId = exerciseRequest.getExerciseId();
        ExerciseDto exerciseDto = exerciseInfoService.findByExerciseId(exerciseId);
        List<QuestionDto> questionDtoList = new ArrayList<>();
        if (exerciseDto != null) {
            questionDtoList = exerciseDto.getQuestions();
        }

        final String exerciseSuccessMessage = generalMessageAccessor.getMessage(null, EXERCISE_FOUND, exerciseId);
        log.info(exerciseSuccessMessage);

        return new QuestionResponse(exerciseSuccessMessage, questionDtoList.size(), questionDtoList);
    }

    @Override
    public ExerciseResponse getAllExercisesInLecture(ExerciseRequest exerciseRequest) {
        exerciseValidationService.validateLecture(exerciseRequest);

        final UUID userId = exerciseRequest.getUserId();
        final UUID lectureId = exerciseRequest.getLectureId();
        LectureDto lecture = lectureService.getLectureById(lectureId);
        UUID topicId = lecture.getTopicId();
        UUID levelId = lecture.getLevelId();
        List<Exercise> exercises = exerciseRepository.findAllByLectureId(lectureId);
        List<ExerciseStatDetailDto> exerciseStatDetailDtoList = new ArrayList<>();

        Map<UUID, ExerciseResultDto> exerciseBestResultMap = exerciseHistoryService.getExerciseBestResultOfUser(
                exercises.stream().map(Exercise::getExerciseId).toList(), userId);

        for (Exercise exercise : exercises) {
            final UUID exerciseId = exercise.getExerciseId();
            final Integer numberOfQuestions = exercise.getQuestions().size();

            ExerciseStatDetailDto exerciseStatDetailDto = ExerciseStatDetailMapper.INSTANCE.convertToExerciseStatDetailDto(exercise);
            exerciseStatDetailDto.setTopicId(topicId);
            exerciseStatDetailDto.setLevelId(levelId);
            exerciseStatDetailDto.setTotalQuestions(numberOfQuestions);
            exerciseStatDetailDto.setBestResult(exerciseBestResultMap.get(exerciseId));
            exerciseStatDetailDtoList.add(exerciseStatDetailDto);
        }

        final String exercisesSuccessMessage = generalMessageAccessor.getMessage(null, EXERCISES_FOUND, lectureId);
        log.info(exercisesSuccessMessage);

        return new ExerciseResponse(
                exercisesSuccessMessage,
                exerciseStatDetailDtoList.size(),
                exerciseStatDetailDtoList);
    }


    @Override
    public Map<UUID, Integer> getExerciseCountForLectures(List<UUID> lectureIdList) {
        List<Exercise> exerciseList = exerciseRepository.findAllByLectureIdIn(lectureIdList);
        return exerciseList.stream()
                .collect(Collectors.groupingBy(Exercise::getLectureId, Collectors.summingInt(e -> 1)));
    }

    @Override
    public Exercise findByQuestionId(UUID questionId) {
        return exerciseRepository.findExerciseByQuestionId(questionId);
    }
}
