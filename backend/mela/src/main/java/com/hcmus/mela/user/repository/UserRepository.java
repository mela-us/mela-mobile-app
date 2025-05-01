package com.hcmus.mela.user.repository;

import com.hcmus.mela.user.model.User;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.UUID;

public interface UserRepository extends MongoRepository<User, UUID> {
    User findByUserId(UUID userId);
}
