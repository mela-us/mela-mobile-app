package com.hcmus.mela.lecture.dto.dto;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TopicDto {

    private UUID topicId;

    private String name;

    private String imageUrl;
}
