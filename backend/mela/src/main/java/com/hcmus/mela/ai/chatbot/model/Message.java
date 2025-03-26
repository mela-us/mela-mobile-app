package com.hcmus.mela.ai.chatbot.model;

import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Date;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document
public class Message {
    @Field(name = "message_id")
    private UUID messageId;

    @Field(name = "role")
    private String role;

    @Field(name = "content")
    private List<Content> content;

    @Field(name = "timestamp")
    private Date timestamp;
}
