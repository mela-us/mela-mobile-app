package com.hcmus.mela.history.model;

import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "lecture_histories")
public class LectureHistory {

    @Id
    @Field(name = "_id")
    private UUID id;

    @Field("user_id")
    private UUID userId;

    @Field("level_id")
    private UUID levelId;

    @Field("topic_id")
    private UUID topicId;

    @Field("lecture_id")
    private UUID lectureId;

    @Field("started_at")
    private LocalDateTime startedAt;

    @Field("completed_at")
    private LocalDateTime completedAt;

    @Field(name = "progress")
    private Integer progress;

    @Field(name = "completed_sections")
    private List<LectureCompletedSection> completedSections;
}