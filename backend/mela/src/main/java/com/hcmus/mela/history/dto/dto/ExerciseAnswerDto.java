package com.hcmus.mela.history.dto.dto;

import lombok.*;

import java.io.Serializable;
import java.util.UUID;

@AllArgsConstructor
@Builder
@Setter
@Getter
@ToString
public class ExerciseAnswerDto {

    private UUID questionId;

    private Boolean isCorrect;

    private String blankAnswer;

    private Integer selectedOption;
}