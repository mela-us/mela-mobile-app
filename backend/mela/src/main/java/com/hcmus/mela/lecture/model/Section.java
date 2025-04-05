package com.hcmus.mela.lecture.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document
public class Section {

    @Field("ordinal_number")
    private Integer ordinalNumber;

    @Field("name")
    private String name;

    @Field("content")
    private String content;

    @Field("url")
    private String url;

    @Field("section_type")
    private String sectionType;
}
