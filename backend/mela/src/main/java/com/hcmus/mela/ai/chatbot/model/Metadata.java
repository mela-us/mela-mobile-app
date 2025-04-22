package com.hcmus.mela.ai.chatbot.model;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
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
    @Enumerated(EnumType.STRING)
    private ConversationStatus status;

    @Field
    private Date createdAt;

    @Field
    private Date updatedAt;

    @Field
    private int totalTokens;
}
