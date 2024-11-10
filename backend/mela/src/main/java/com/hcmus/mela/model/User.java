package com.hcmus.mela.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "users")
@EqualsAndHashCode(of = "userId")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;

    @Column(name = "username", unique = true)
    private String username;

    @Column(name = "password_hash")
    private String password;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "image_url")
    private String imageUrl;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @Column(name = "birthday")
    private LocalDate birthday;

    @Enumerated(EnumType.STRING)
    @Column(name = "user_role")
    private UserRole userRole;
}