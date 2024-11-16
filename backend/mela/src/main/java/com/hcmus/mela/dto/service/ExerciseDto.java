package com.hcmus.mela.dto.service;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ExerciseDto {
    private Integer exerciseId;

    private Integer lectureId;

    private String exerciseName;

    private Integer exerciseNumber;
}
