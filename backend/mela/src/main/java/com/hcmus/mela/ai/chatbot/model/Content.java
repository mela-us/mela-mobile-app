package com.hcmus.mela.ai.chatbot.model;

import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document
public class Content {
    @Field(name = "type")
    private String type;

    @Field(name = "data")
    private String data;
}
