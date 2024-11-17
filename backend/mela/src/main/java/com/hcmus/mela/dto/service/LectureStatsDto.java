package com.hcmus.mela.dto.service;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LectureStatsDto {
    private Integer lectureId;
    private Integer passExercisesCount;
    private LocalDateTime studyTime;
}
