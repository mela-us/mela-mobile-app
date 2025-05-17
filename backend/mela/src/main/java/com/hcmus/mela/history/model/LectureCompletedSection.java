package com.hcmus.mela.history.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Document
public class LectureCompletedSection {

    @Field(name = "completed_at")
    private LocalDateTime completedAt;

    @Field(name = "ordinal_number")
    private Integer ordinalNumber;
}