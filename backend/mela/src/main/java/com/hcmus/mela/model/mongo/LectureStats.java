package com.hcmus.mela.model.mongo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LectureStats {
    @Field("_id")
    private Integer lectureId;
    @Field("pass_count")
    private Integer passExercisesCount;
    @Field("study_time")
    private LocalDateTime studyTime;
}
