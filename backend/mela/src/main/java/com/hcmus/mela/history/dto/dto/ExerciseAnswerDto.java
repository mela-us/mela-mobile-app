package com.hcmus.mela.history.dto.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import java.io.Serializable;
import java.util.UUID;

@AllArgsConstructor
@Builder
@Setter
@Getter
@ToString
public class ExerciseAnswerDto {

    @Schema(description = "Id of the question", example = "9d299317-16c0-4e0b-acbd-0a914782efd5")
    private UUID questionId;

    @Schema(description = "Is the answer correct", example = "false")
    private Boolean isCorrect;

    @Schema(description = "Answer of the question", example = "")
    private String blankAnswer;

    @Schema(description = "Selected option", example = "4")
    private Integer selectedOption;
}