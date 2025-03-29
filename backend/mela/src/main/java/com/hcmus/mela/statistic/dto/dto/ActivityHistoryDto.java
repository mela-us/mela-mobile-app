package com.hcmus.mela.statistic.dto.dto;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ActivityHistoryDto {

    @Enumerated(EnumType.STRING)
    private ActivityType type;

    private LocalDateTime latestDate;

    private String topicName;

    private String lectureName;

    private ExerciseActivityDto exercise;

    private SectionActivityDto section;
}
