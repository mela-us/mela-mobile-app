package com.hcmus.mela.service;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;

import com.hcmus.mela.repository.UserRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hcmus.mela.model.User;
import com.hcmus.mela.model.UserOtp;
import com.hcmus.mela.repository.UserOtpRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OtpService {
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    private final UserOtpRepository userOtpRepository;

    private final UserRepository userRepository;

    private static final int OTP_EXPIRY_MINUTES = 5;


    public String generateOtp() {
        Random random = new Random();
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            otp.append(random.nextInt(10));
        }
        return otp.toString();
    }    

    public void setOtpToUser(String otp, User user) {
        Optional<UserOtp> optionalUserOtp = userOtpRepository.findByUser(user);
        UserOtp userOtp;
        if (optionalUserOtp.isEmpty()) {
            userOtp = new UserOtp();
        }
        else {
            userOtp = optionalUserOtp.get();
        }
        userOtp.setUser(user);
        userOtp.setOtpCode(bCryptPasswordEncoder.encode(otp));
        userOtp.setExpirationDate(LocalDateTime .now().plusMinutes(OTP_EXPIRY_MINUTES));

        userOtpRepository.save(userOtp);
    }

    public boolean validateOtpOfUser(String otp, String email) {
        User user = userRepository.findByUsername(email);
        if (user == null) {
            return false;
        }
        Optional<UserOtp> userOtp = userOtpRepository.findByUser(user);
        if (userOtp.isEmpty()) {
            return false;
        }
        if (!userOtp.get().getOtpCode().equals(bCryptPasswordEncoder.encode(otp))
                && userOtp.get().getExpirationDate().compareTo(LocalDateTime.now()) < 0) {
            return false;
        }
        return true;
    }
}
