package com.hcmus.mela.lecture.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LectureSection {
    @Field("ordinal_number")
    private Integer ordinalNumber;

    private String name;

    private String content;

    private String url;

    @Field("section_type")
    private String sectionType;
}
