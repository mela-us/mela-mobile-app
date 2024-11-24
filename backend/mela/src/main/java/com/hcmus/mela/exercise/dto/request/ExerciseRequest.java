package com.hcmus.mela.exercise.dto.request;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ExerciseRequest {
    private Integer exerciseId;

    private Integer lectureId;

    private Integer userId;
}
