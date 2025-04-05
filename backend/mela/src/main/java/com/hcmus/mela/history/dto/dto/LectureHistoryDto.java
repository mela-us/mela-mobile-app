package com.hcmus.mela.history.dto.dto;

import lombok.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Setter
@Getter
public class LectureHistoryDto {

    private UUID id;

    private UUID userId;

    private UUID levelId;

    private UUID topicId;

    private UUID lectureId;

    private LocalDateTime startedAt;

    private LocalDateTime completedAt;

    private Integer progress;

    private List<LectureCompletedSectionDto> completedSections;
}