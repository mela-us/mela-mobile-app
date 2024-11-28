package com.hcmus.mela.lecture.dto.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LectureSectionDto {
    private Integer ordinalNumber;
    private String name;
    private String content;
    private String url;
    private String sectionType;
}
