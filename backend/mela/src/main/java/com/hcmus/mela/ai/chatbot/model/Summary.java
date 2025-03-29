package com.hcmus.mela.ai.chatbot.model;

import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document
public class Summary {
    @Field(name = "latest_update")
    private Date latestUpdate;

    @Field(name = "context")
    private String context;
}
