package com.hcmus.mela.history.dto.dto;

import lombok.*;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@AllArgsConstructor
@Builder
@Setter
@Getter
@ToString
public class LectureHistoryDto implements Serializable {

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