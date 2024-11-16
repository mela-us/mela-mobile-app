package com.hcmus.mela.repository.mongo;

import com.hcmus.mela.model.mongo.Exercise;
import com.hcmus.mela.model.mongo.LectureStats;

import java.util.List;

public interface ExerciseRepository {
    List<Exercise> findExercisesByLectureId(Integer lectureId);
}

