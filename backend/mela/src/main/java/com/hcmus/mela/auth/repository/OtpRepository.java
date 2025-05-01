package com.hcmus.mela.auth.repository;

import com.hcmus.mela.auth.model.Otp;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.UUID;

public interface OtpRepository extends MongoRepository<Otp, UUID> {

    Otp findByUserId(UUID userId);

    void deleteByUserId(UUID userId);
}
