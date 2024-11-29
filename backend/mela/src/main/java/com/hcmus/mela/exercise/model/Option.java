package com.hcmus.mela.exercise.model;

import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document
public class Option {
    @Field(name = "ordinal_number")
    private Integer ordinalNumber;

    @Field(name = "content")
    private String content;

    @Field(name = "is_correct")
    private Boolean isCorrect;
}
