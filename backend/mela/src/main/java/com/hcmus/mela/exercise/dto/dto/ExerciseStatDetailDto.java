package com.hcmus.mela.exercise.dto.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ExerciseStatDetailDto {
    private UUID exerciseId;

    private UUID lectureId;

    private UUID topicId;

    private UUID levelId;

    private String exerciseName;

    private Integer ordinalNumber;

    private Integer totalQuestions;

    private ExerciseResultDto bestResult;
}