package com.hcmus.mela.exercise.dto.request;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ExerciseRequest {
    private Integer exerciseId;

    private Integer lectureId;

    private UUID userId;
}
