package com.hcmus.mela.model.mongo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "lectures")
public class Lecture {
    @Id
    @Field("lecture_id")
    private Integer lectureId;

    @Field("name")
    private String lectureName;
    @Field("lecture_content")
    private String lectureContent;

    @DBRef
    private Topic topic;
    @DBRef
    private Level level;

}
