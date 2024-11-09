package com.hcmus.mela.security.jwt;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
@RequiredArgsConstructor
public class JwtTokenForgetPasswordService {
    private final JwtForgetPasswordProperties jwtForgetPasswordProperties;

    public String generateToken(String username) {
        if (jwtForgetPasswordProperties.getSecretKey() == null) {
            throw new IllegalStateException("Secret key is not configured");
        }

        //@formatter:off
        return JWT.create()
                .withSubject(username)
                .withIssuer(jwtForgetPasswordProperties.getIssuer())
                .withIssuedAt(new Date())
                .withExpiresAt(new Date(System.currentTimeMillis()
                        + jwtForgetPasswordProperties.getExpirationMinute() * 60 * 1000))
                .sign(Algorithm.HMAC256(jwtForgetPasswordProperties.getSecretKey().getBytes()));
        //@formatter:on
    }

    public boolean validateToken(String token, String username) {
        try {
            if (jwtForgetPasswordProperties.getSecretKey() == null) {
                throw new IllegalStateException("Secret key is not configured");
            }

            final JWTVerifier jwtVerifier = JWT.require(Algorithm.HMAC256(jwtForgetPasswordProperties.getSecretKey().getBytes())).build();
            DecodedJWT decodedJWT = jwtVerifier.verify(token);
            return (decodedJWT.getExpiresAt().before(new Date()) && decodedJWT.getSubject().equals(username));
        } catch (Exception ex) {
            return false;
        }
    }
}
