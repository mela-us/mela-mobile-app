package com.hcmus.mela.exercise.service;
import com.hcmus.mela.exercise.dto.request.ExerciseRequest;
import com.hcmus.mela.exercise.dto.response.ExerciseResponse;
import com.hcmus.mela.exercise.dto.response.QuestionResponse;
import com.hcmus.mela.exercise.model.Exercise;
import com.hcmus.mela.exercise.model.Question;

import java.util.List;
import java.util.Map;
import java.util.UUID;

public interface ExerciseService {

    QuestionResponse getExercise(ExerciseRequest exerciseRequest);

    ExerciseResponse getAllExercisesInLecture(ExerciseRequest exerciseRequest);

    Exercise findByQuestionId(UUID questionId);

    Exercise updateQuestionHint(Exercise exercise);
}
