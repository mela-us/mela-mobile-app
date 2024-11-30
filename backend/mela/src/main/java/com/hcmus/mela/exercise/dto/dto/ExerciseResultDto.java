package com.hcmus.mela.exercise.dto.dto;


import com.hcmus.mela.exercise.model.ExerciseStatus;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ExerciseResultDto {
    private Integer totalCorrectAnswers;

    private Integer totalAnswers;

    private ExerciseStatus status;
}
