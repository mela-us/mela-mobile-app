package com.hcmus.mela.lecture.dto.dto;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LectureOfSectionDto {

    private UUID lectureId;

    private UUID topicId;

    private UUID levelId;

    private String name;

    private Integer ordinalNumber;
}
