package com.hcmus.mela.exercise.dto.dto;


import com.hcmus.mela.exercise.model.ExerciseStatus;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ExerciseResultDto {

    private Integer totalCorrectAnswers;

    private Integer totalAnswers;

    private ExerciseStatus status;
}
