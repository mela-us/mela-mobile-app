package com.hcmus.mela.history.dto.dto;

import lombok.*;

import java.util.UUID;

@AllArgsConstructor
@Builder
@Setter
@Getter
@ToString
public class CheckedAnswerDto {

    private UUID questionId;

    private Boolean isCorrect;
}