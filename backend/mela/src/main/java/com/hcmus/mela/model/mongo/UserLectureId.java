package com.hcmus.mela.model.mongo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Field;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserLectureId implements Serializable {
    @Field("user_id")
    private Integer userId;
    @Field("lecture_id")
    private Integer lectureId;

}
