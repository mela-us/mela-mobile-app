package com.hcmus.mela.exercise.repository;

import com.hcmus.mela.exercise.model.Exercise;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;
import java.util.UUID;

public interface ExerciseCustomRepository {

    Exercise updateQuestionHint(Exercise exercise);
}
