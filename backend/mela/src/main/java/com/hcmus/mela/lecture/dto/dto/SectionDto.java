package com.hcmus.mela.lecture.dto.dto;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SectionDto {

    private Integer ordinalNumber;

    private String name;

    private String content;

    private String url;

    private String sectionType;
}
