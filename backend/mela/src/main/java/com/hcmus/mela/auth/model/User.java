package com.hcmus.mela.auth.model;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "users")
public class User {

    @Id
    @Field(name = "_id")
    private UUID userId;

    private String username;

    private String password;

    @Field("full_name")
    private String fullname;

    @Field("image_url")
    private String imageUrl;

    @Field("created_at")
    private Date createdAt;

    @Field("updated_at")
    private Date updatedAt;

    private Date birthday;

    @Field("user_role")
    private UserRole userRole;
}
