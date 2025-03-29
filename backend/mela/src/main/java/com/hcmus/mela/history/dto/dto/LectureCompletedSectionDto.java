package com.hcmus.mela.history.dto.dto;

import lombok.*;

import java.io.Serializable;
import java.time.LocalDateTime;

@AllArgsConstructor
@Builder
@Setter
@Getter
@ToString
public class LectureCompletedSectionDto {

    private final LocalDateTime completedAt;

    private final Integer ordinalNumber;
}