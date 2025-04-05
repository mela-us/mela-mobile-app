package com.hcmus.mela.history.dto.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@AllArgsConstructor
@Builder
@Setter
@Getter
public class ExerciseHistoryDto {

    private UUID id;

    private UUID lectureId;

    private UUID userId;

    private UUID exerciseId;

    private UUID levelId;

    private UUID topicId;

    private Double score;

    private LocalDateTime startedAt;

    private LocalDateTime completedAt;

    private List<ExerciseAnswerDto> answers;
}