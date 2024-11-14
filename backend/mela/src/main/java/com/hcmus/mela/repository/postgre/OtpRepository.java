package com.hcmus.mela.repository.postgre;

import com.hcmus.mela.model.postgre.Otp;
import com.hcmus.mela.model.postgre.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OtpRepository extends JpaRepository<Otp, Long> {
    Otp findByUser(User user);

    Otp findByUserUsername(String username);
}
