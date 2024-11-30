package com.hcmus.mela.lecture.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LectureDto {
    private UUID lectureId;
    private String lectureName;
    private UUID levelId;
    private UUID topicId;
    private Integer exerciseCount;
}
