package com.hcmus.mela.repository;

import com.hcmus.mela.model.Otp;
import com.hcmus.mela.model.User;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OtpRepository extends JpaRepository<Otp, Long> {
    Otp findByUser(User user);

    Otp findByUserUsername(String username);
}
