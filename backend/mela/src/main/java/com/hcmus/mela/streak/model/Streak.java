package com.hcmus.mela.streak.model;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Date;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "streaks")
public class Streak {
    @Id
    @Field(name = "_id")
    private UUID userId;

    @Field(name = "streak_days")
    private Integer streakDays;

    @Field(name = "started_at")
    private Date startedAt;

    @Field(name = "updated_at")
    private Date updatedAt;

    @Field(name = "longest_streak")
    private Integer longestStreak;
}
