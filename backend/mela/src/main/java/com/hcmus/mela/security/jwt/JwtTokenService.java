package com.hcmus.mela.security.jwt;

import com.hcmus.mela.model.postgre.User;
import com.hcmus.mela.repository.postgre.UserRepository;
import com.hcmus.mela.security.utils.SecurityConstants;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.util.Strings;
import org.springframework.stereotype.Service;

import java.util.Date;

@Slf4j
@Service
@RequiredArgsConstructor
public class JwtTokenService {

    private final UserRepository userRepository;

    private final JwtTokenManager jwtTokenManager;

    public Long getUserIdFromToken(String token) {
        return jwtTokenManager.getUserIdFromToken(token);
    }

    public String getUsernameFromToken(String token) {
        return jwtTokenManager.getUsernameFromToken(token);
    }

    public boolean validateToken(String token) {

        final String username = getUsernameFromToken(token);

        User user = userRepository.findByUsername(username);

        return jwtTokenManager.validateToken(token, user.getUsername());
    }

    public String generateRefreshToken(User user) {
        return jwtTokenManager.generateRefreshToken(user);
    }

    public String generateAccessToken(User user) {
        return jwtTokenManager.generateAccessToken(user);
    }

    public Date getExpirationDate(String token) {
        return jwtTokenManager.getExpirationDate(token);
    }

    public long getRemainingTimeBeforeExpiration(String token){
        return jwtTokenManager.getRemainingTimeBeforeExpiration(token);
    }

    public String extractTokenFromAuthorizationHeader(String authorizationHeader) {
        return authorizationHeader.replace(SecurityConstants.TOKEN_PREFIX, Strings.EMPTY);
    }
}
