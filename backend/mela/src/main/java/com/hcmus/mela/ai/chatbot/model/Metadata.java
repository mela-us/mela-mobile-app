package com.hcmus.mela.ai.chatbot.model;

import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Date;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document
public class Metadata {
    @Field(name = "status")
    private String status;

    @Field
    private Date createdAt;

    @Field
    private int totalTokens;
}
