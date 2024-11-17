package com.hcmus.mela.model.mongo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.json.JsonObject;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "lectures")
public class Lecture {
    @Field("lecture_id")
    @Indexed(unique = true)
    private Integer lectureId;

    @Field("lecture_name")
    private String lectureName;
    @Field("lecture_content")
    private LectureContent lectureContent;
    @Field("level_id")
    private Integer levelId;
    @Field("topic_id")
    private Integer topicId;

    @Field("exercise_count")
    private Integer exerciseCount;
}
