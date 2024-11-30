package com.hcmus.mela.lecture.repository;

import com.hcmus.mela.lecture.model.LectureExerciseTotal;

import java.util.List;
import java.util.UUID;

public interface ExerciseCountRepository {

    List<LectureExerciseTotal> countTotalExerciseOfLectures();

    List<LectureExerciseTotal> countTotalPassExerciseOfLectures(UUID userId);
}
