package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.dto.dto.ExerciseResultDto;
import com.hcmus.mela.exercise.dto.request.ExerciseResultRequest;
import com.hcmus.mela.exercise.dto.response.ExerciseResultResponse;
import com.hcmus.mela.exercise.mapper.ExerciseResultMapper;
import com.hcmus.mela.exercise.model.Exercise;
import com.hcmus.mela.exercise.model.ExerciseResult;
import com.hcmus.mela.exercise.model.ExerciseResultCount;
import com.hcmus.mela.exercise.model.ExerciseStatus;
import com.hcmus.mela.exercise.repository.ExerciseRepository;
import com.hcmus.mela.exercise.repository.ExerciseResultRepository;
import com.hcmus.mela.lecture.model.Lecture;
import com.hcmus.mela.lecture.service.LectureDetailService;
import com.hcmus.mela.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExerciseResultServiceImpl implements ExerciseResultService {
    private static final String RESULTS_FOUND = "results_found_successful";
    private static final String RESULT_SAVED = "result_saved_successful";
    private final GeneralMessageAccessor generalMessageAccessor;
    private final ExerciseResultRepository exerciseResultRepository;
    private final ExerciseRepository exerciseRepository;
    private final LectureDetailService lectureDetailService;

    @Override
    public List<ExerciseResult> findAllByUserIdAndExerciseId(UUID userId, UUID exerciseId) {
        return exerciseResultRepository.findAllByUserIdAndExerciseId(userId, exerciseId);
    }

    @Override
    public ExerciseResultDto getBestExerciseResult(UUID userId, UUID exerciseId) {
        ExerciseResult bestResult = exerciseResultRepository.getBestExerciseResult(userId, exerciseId);
        if (bestResult == null) {
            return null;
        }

        final String resultSuccessMessage = generalMessageAccessor.getMessage(null, RESULTS_FOUND, exerciseId, userId);
        log.info(resultSuccessMessage);
        return ExerciseResultMapper.INSTANCE.convertToExerciseResultDto(bestResult);
    }

    @Override
    public ExerciseResultResponse saveResult(ExerciseResultRequest exerciseResultRequest, UUID userId) {
        final ExerciseResult exerciseResult = ExerciseResultMapper.INSTANCE.convertToExerciseResult(exerciseResultRequest);

        final Exercise exercise = exerciseRepository.findByExerciseId(exerciseResultRequest.getExerciseId());

        exerciseResult.setUserId(userId);

        exerciseResult.setLectureId(exercise.getLectureId());

        final Lecture lecture = lectureDetailService.getLectureById(exercise.getLectureId());

        exerciseResult.setTopicId(lecture.getTopicId());

        exerciseResult.setLectureId(lecture.getLectureId());

        exerciseResult.setLevelId(lecture.getLevelId());

        ExerciseStatus status = ExerciseStatus.IN_PROGRESS;
        if (exerciseResultRequest.getTotalAnswers() == 0) {
            status = ExerciseStatus.NOT_START;
        } else if (exerciseResultRequest.getTotalCorrectAnswers() >= 0.8 * exerciseResultRequest.getTotalAnswers()) {
            status = ExerciseStatus.PASS;
        }
        exerciseResult.setStatus(status);

        exerciseResult.setExerciseResultId(UUID.randomUUID());

        exerciseResultRepository.save(exerciseResult);

        final String saveResultSuccessMessage = generalMessageAccessor.getMessage(null, RESULT_SAVED, userId, exercise.getExerciseId());

        log.info("Exercise {} result saved successfully!", exercise.getExerciseId());

        return new ExerciseResultResponse(saveResultSuccessMessage);
    }

    @Override
    public List<ExerciseResultCount> countTotalPassExerciseOfLectures(UUID userId) {
        return exerciseResultRepository.countTotalPassExerciseOfLectures(userId);
    }
}