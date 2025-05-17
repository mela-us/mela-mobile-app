package com.hcmus.mela.lecture.dto.dto;

import lombok.*;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LectureDto {

    private UUID lectureId;

    private UUID levelId;

    private UUID topicId;

    private String name;

    private String description;

    private List<SectionDto> sections;
}