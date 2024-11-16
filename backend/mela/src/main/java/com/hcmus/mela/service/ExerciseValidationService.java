package com.hcmus.mela.service;


import com.hcmus.mela.dto.request.ExerciseRequest;
import com.hcmus.mela.exceptions.custom.ExerciseException;
import com.hcmus.mela.model.mongo.Exercise;
import com.hcmus.mela.repository.mongo.ExerciseRepository;
import com.hcmus.mela.utils.ExceptionMessageAccessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExerciseValidationService {
    private static final String EXERCISE_NOT_EXISTS = "exercise_id_must_exist";

    private static final String LECTURE_NOT_EXISTS = "lecture_id_must_exist";

    private final ExerciseRepository exerciseRepository;

    private final ExceptionMessageAccessor exceptionMessageAccessor;

    public void validateExercise(ExerciseRequest exerciseRequest) {
        final Integer exerciseId = exerciseRequest.getExerciseId();
        checkExerciseId(exerciseId);
    }

    public void validateLecture(ExerciseRequest exerciseRequest) {
        final Integer lectureId = exerciseRequest.getLectureId();
        checkLectureId(lectureId);
    }

    private void checkExerciseId(Integer exerciseId) {
        final boolean existsByExerciseId = exerciseRepository.existsByExerciseId(exerciseId);
        if (!existsByExerciseId) {
            log.warn("Exercise ID {} doesn't exist", exerciseId);

            final String notExistsExerciseId = exceptionMessageAccessor.getMessage(null, EXERCISE_NOT_EXISTS);
            throw new ExerciseException(notExistsExerciseId);
        }
    }

    private void checkLectureId(Integer lectureId) {
        final boolean existsByLectureId = exerciseRepository.existsByLectureId(lectureId);
        if (!existsByLectureId) {
            log.warn("Lecture ID {} doesn't exist", lectureId);

            final String notExistsLectureId = exceptionMessageAccessor.getMessage(null, LECTURE_NOT_EXISTS);
            throw new ExerciseException(notExistsLectureId);
        }
    }
}
