package com.hcmus.mela.dto.service;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LectureDto {
    private Integer lectureId;
    private String lectureName;
    private Integer levelId;
    private Integer topicId;
    private Integer exerciseCount;
}
