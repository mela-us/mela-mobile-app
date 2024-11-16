package com.hcmus.mela.model.mongo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "levels")
public class Level {
    @Field("level_id")
    @Indexed(unique = true)
    private Integer levelId;

    @Field("level_name")
    private String levelName;
}
