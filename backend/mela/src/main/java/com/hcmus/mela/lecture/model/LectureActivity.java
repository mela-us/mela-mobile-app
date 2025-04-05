package com.hcmus.mela.lecture.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LectureActivity extends Lecture {

    @Field("completed_at")
    private LocalDateTime completedAt;

    public int compareTo(LectureActivity other) {
        return this.getLectureId().compareTo(other.getLectureId());
    }
}
