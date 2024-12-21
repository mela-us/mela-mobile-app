package com.hcmus.mela.auth.repository;

import com.hcmus.mela.auth.model.Otp;
import com.hcmus.mela.auth.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface OtpRepository extends JpaRepository<Otp, UUID> {
    Otp findByUser(User user);

    Otp findByUserUsername(String username);
}
