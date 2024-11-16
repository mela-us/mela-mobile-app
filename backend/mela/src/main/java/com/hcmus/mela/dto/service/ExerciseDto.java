package com.hcmus.mela.dto.service;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ExerciseDto {
    private Integer exerciseId;
    private Integer lectureId;
    private String exerciseName;
    private int exerciseNumber;
    private Integer questionsCount;
}
