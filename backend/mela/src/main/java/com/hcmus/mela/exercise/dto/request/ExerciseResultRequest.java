package com.hcmus.mela.exercise.dto.request;

import com.hcmus.mela.exercise.model.ExerciseStatus;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Date;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ExerciseResultRequest {
    @NotEmpty(message = "{login_username_not_empty}")
    private UUID exerciseId;

    @NotEmpty(message = "{login_username_not_empty}")
    private Integer totalCorrectAnswers;

    @NotEmpty(message = "{login_username_not_empty}")
    private Integer totalAnswers;

    @NotEmpty(message = "{login_username_not_empty}")
    private Date startAt;

    @NotEmpty(message = "{login_username_not_empty}")
    private Date endAt;
}
