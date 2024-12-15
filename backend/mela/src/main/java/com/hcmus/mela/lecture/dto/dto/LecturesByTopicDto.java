package com.hcmus.mela.lecture.dto.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LecturesByTopicDto {

    private UUID topicId;

    private String topicName;

    private List<LectureDetailDto> lectures;
}
