package com.hcmus.mela.history.dto.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@AllArgsConstructor
@Builder
@Setter
@Getter
public class LectureCompletedSectionDto {

    private final LocalDateTime completedAt;

    private final Integer ordinalNumber;
}