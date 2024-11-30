package com.hcmus.mela.lecture.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LectureExerciseTotal {

    @Id
    private UUID lectureId;

    private Integer total;
}
