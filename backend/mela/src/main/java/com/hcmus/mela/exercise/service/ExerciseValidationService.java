package com.hcmus.mela.exercise.service;


import com.hcmus.mela.exercise.dto.request.ExerciseRequest;
import com.hcmus.mela.exercise.exception.exception.ExerciseException;
import com.hcmus.mela.exercise.repository.ExerciseRepository;
import com.hcmus.mela.utils.ExceptionMessageAccessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;


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
