package com.hcmus.mela.lecture.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.List;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Document(collection = "lectures")
public class Lecture {

    @Id
    private UUID lectureId;

    @Field("level_id")
    private UUID levelId;

    @Field("topic_id")
    private UUID topicId;

    @Field("name")
    private String name;

    @Field("ordinal_number")
    private Integer ordinalNumber;

    @Field("description")
    private String description;

    @Field("sections")
    private List<Section> sections;

    @Field("total_exercises")
    private Integer totalExercises;
}
