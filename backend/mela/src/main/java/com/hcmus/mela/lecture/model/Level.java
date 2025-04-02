package com.hcmus.mela.lecture.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "levels")
public class Level {

    @Id
    private UUID levelId;

    @Field("name")
    private String name;

    @Field("image_url")
    private String imageUrl;
}
