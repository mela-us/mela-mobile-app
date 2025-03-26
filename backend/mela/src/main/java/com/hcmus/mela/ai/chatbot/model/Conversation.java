package com.hcmus.mela.ai.chatbot.model;

import jakarta.persistence.Id;
import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "conversations")
public class Conversation {
    @Id
    @Field(name = "_id")
    private UUID conversationId;

    @Field(name = "user_id")
    private UUID userId;

    @Field(name = "model")
    private String model;

    @Field(name = "title")
    private String title;

    @Field(name = "messages")
    private List<Message> messages;

    @Field(name = "summary")
    private Summary summary;

    @Field(name = "metadata")
    private Metadata metadata;
}
