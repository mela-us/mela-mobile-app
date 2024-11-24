package com.hcmus.mela.lecture.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "lectures")
public class UserLecture {
    @Field("user_id")
    private Integer userId;
    @Field("lecture_id")
    private Integer lectureId;

    @Field("study_time")
    private LocalDateTime studyTime;
}
