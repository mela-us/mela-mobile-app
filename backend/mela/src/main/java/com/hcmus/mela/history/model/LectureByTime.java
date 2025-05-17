package com.hcmus.mela.history.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LectureByTime {

    @Id
    @Field(name = "lecture_id")
    private UUID lectureId;

    @Field("completed_at")
    private LocalDateTime completedAt;
}
