package com.hcmus.mela.lecture.dto.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LectureInfoDto {
    
    private UUID lectureId;

    private UUID topicId;

    private UUID levelId;

    private String name;
}
