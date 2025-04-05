package com.hcmus.mela.exercise.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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
