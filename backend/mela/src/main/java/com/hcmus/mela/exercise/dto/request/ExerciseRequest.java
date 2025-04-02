package com.hcmus.mela.exercise.dto.request;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ExerciseRequest {

    private UUID exerciseId;

    private UUID lectureId;

    private UUID userId;
}
