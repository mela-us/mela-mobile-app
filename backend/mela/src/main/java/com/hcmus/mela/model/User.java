package com.hcmus.mela.model;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Date;
import java.sql.Timestamp;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "users")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long user_id;

	@Column(name = "username", unique = true, nullable = false)
	private String username;

	@Column(name = "password_hash")
	private String password;

	@Column(name = "full_name")
	private String fullName;

	@Column(name = "image_url")
	private String imageUrl;

	@Column(name = "created_at")
	private Timestamp createdAt;

	@Column(name = "updated_at")
	private Timestamp updatedAt;

	@Column(name = "birthday")
	private Date birthday;

	@Enumerated(EnumType.STRING)
	private UserRole userRole;
}
