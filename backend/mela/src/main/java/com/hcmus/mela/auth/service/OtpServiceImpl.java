package com.hcmus.mela.auth.service;

import com.hcmus.mela.auth.model.User;
import com.hcmus.mela.auth.model.Otp;
import com.hcmus.mela.auth.repository.OtpRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Random;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class OtpServiceImpl implements OtpService {

    private static final int OTP_EXPIRY_MINUTES = 5;

    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    private final OtpRepository otpRepository;

    private final Random random = new Random();

    @Override
    public String generateOtpCode(int length) {
        StringBuilder otpCode = new StringBuilder();
        for (int i = 0; i < length; i++) {
            otpCode.append(this.random.nextInt(10));
        }
        return otpCode.toString();
    }

    @Override
    public void cacheOtpCode(String otpCode, User user) {
        Otp otp = otpRepository.findByUser(user);
        if (otp == null) {
            otp = new Otp();
        }
        otp.setUser(user);
        otp.setOtpCode(bCryptPasswordEncoder.encode(otpCode));
        otp.setExpireAt(LocalDateTime.now().plusMinutes(OTP_EXPIRY_MINUTES));

        otpRepository.save(otp);
    }

    @Override
    public boolean validateOtpOfUser(String otpCode, String username) {
        Otp otp = otpRepository.findByUserUsername(username);
        if (otp == null) {
            return false;
        }
        if (!bCryptPasswordEncoder.matches(otpCode, otp.getOtpCode())
                || otp.getExpireAt().isBefore(LocalDateTime.now())) {
            return false;
        }
        otpRepository.deleteById(otp.getOtpId());
        return true;
    }

    @Override
    public void deleteOtpCodeByUserId(UUID userId) {
        otpRepository.deleteByUser_UserId(userId);
    }
}
