package com.hcmus.mela.lecture.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "lectures")
public class Lecture {
    @Field("lecture_id")
    @Indexed(unique = true)
    private UUID lectureId;

    @Field("lecture_name")
    private String lectureName;
    @Field("lecture_content")
    private LectureContent lectureContent;
    @Field("level_id")
    private UUID levelId;
    @Field("topic_id")
    private UUID topicId;

    @Field("exercise_count")
    private Integer exerciseCount;
}
