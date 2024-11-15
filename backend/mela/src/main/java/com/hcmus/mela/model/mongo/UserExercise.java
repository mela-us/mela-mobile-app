package com.hcmus.mela.model.mongo;

import com.hcmus.mela.model.postgre.UserRole;
import jakarta.persistence.Column;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "users_exercises")
public class UserExercise {
    @Id
    private UserExerciseId userExerciseId;

    @Field("right_answers")
    private Integer rightAnswers;

    @Field("test_duration")
    private LocalTime testDuration;

    @Field("test_time")
    private LocalDateTime testAt;

    @Enumerated(EnumType.STRING)
    private ExerciseStatus status;
}
