package com.hcmus.mela.exercise.dto.dto;

import lombok.*;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ExerciseDto {

    private UUID exerciseId;

    private UUID lectureId;

    private String exerciseName;

    private Integer ordinalNumber;

    private List<QuestionDto> questions;
}