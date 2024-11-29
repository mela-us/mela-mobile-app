package com.hcmus.mela.lecture.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.List;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "lectures")
public class Lecture {

    @Id
    private UUID lectureId;

    @Field("level_id")
    private UUID levelId;

    @Field("topic_id")
    private UUID topicId;

    private String name;

    private String description;

    private List<LectureSection> sections;
}
