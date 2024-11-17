package com.hcmus.mela.dto.service;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserExerciseDto {

    private Integer userId;

    private Integer exerciseId;

    private Integer rightAnswer;

    private String status;

    private Instant testStart;

    private Instant testEnd;

    private Integer totalAnswer;
}
