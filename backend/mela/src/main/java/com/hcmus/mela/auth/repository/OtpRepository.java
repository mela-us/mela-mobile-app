package com.hcmus.mela.auth.repository;

import com.hcmus.mela.auth.model.Otp;
import com.hcmus.mela.auth.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OtpRepository extends JpaRepository<Otp, Long> {
    Otp findByUser(User user);

    Otp findByUserUsername(String username);
}
