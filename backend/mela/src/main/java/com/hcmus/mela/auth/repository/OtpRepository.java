package com.hcmus.mela.auth.repository;

import com.hcmus.mela.auth.model.User;
import com.hcmus.mela.auth.model.Otp;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.UUID;

public interface OtpRepository extends MongoRepository<Otp, UUID> {
    Otp findByUser(User user);

    Otp findByUserUsername(String username);

    void deleteByUser(User user);

    void deleteByUser_UserId(UUID userUserId);
}
