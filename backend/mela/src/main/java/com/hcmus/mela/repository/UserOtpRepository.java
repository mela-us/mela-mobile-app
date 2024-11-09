package com.hcmus.mela.repository;

import com.hcmus.mela.model.UserOtp;
import com.hcmus.mela.model.User;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserOtpRepository extends JpaRepository<UserOtp, Long> {
    Optional<UserOtp> findByUserAndOtpCode(User user, String otpCode);
    void deleteByUser(User user);
}
