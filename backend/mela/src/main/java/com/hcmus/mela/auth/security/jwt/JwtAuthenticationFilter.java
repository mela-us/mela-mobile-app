package com.hcmus.mela.auth.security.jwt;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.hcmus.mela.auth.exception.response.ApiExceptionResponse;
import com.hcmus.mela.auth.service.TokenStoreService;
import com.hcmus.mela.auth.service.UserDetailsServiceImpl;
import com.hcmus.mela.auth.security.utils.SecurityConstants;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.util.Strings;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Service;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Objects;

@Slf4j
@Service
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtTokenManager jwtTokenManager;
    private final UserDetailsServiceImpl userDetailsService;
    private final TokenStoreService tokenStoreService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, @NonNull HttpServletResponse response, @NonNull FilterChain chain)
            throws IOException, ServletException {

        final String header = request.getHeader(SecurityConstants.HEADER_STRING);
        String authToken = null;
        String username = null;

        if (isValidHeader(header)) {
            authToken = header.replace(SecurityConstants.TOKEN_PREFIX, Strings.EMPTY);

            try {
                username = jwtTokenManager.getUsernameFromToken(authToken);
            } catch (Exception e) {
                sendErrorResponse(response, "Invalid token!");
                return;
            }
        }

        if (shouldProceed(username)) {
            chain.doFilter(request, response);
            return;
        }

        if (isTokenBlacklisted(authToken)) {
            sendErrorResponse(response, "Token is in blacklist");
            return;
        }

        if (!isValidToken(authToken, username)) {
            sendErrorResponse(response, "Invalid token!");
            return;
        }

        setAuthentication(username, request);
        chain.doFilter(request, response);
    }

    private boolean isValidHeader(String header) {
        return Objects.nonNull(header) && header.startsWith(SecurityConstants.TOKEN_PREFIX);
    }

    private boolean shouldProceed(String username) {
        return Objects.isNull(username) || Objects.nonNull(SecurityContextHolder.getContext().getAuthentication());
    }

    private boolean isTokenBlacklisted(String authToken) {
        return tokenStoreService.isAccessTokenBlacklisted(authToken);
    }

    private boolean isValidToken(String authToken, String username) {
        UserDetails user = userDetailsService.loadUserByUsername(username);
        return jwtTokenManager.validateToken(authToken, user.getUsername());
    }

    private void setAuthentication(String username, HttpServletRequest request) {
        UserDetails user = userDetailsService.loadUserByUsername(username);
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
        authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        log.info("Authentication successful for username: {}", username);
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType("application/json");

        ApiExceptionResponse apiExceptionResponse = new ApiExceptionResponse(
                message,
                HttpStatus.UNAUTHORIZED,
                LocalDateTime.now()
        );
        ObjectMapper objectMapper = new ObjectMapper();
        JavaTimeModule javaTimeModule = new JavaTimeModule();
        objectMapper.registerModule(javaTimeModule);
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        objectMapper.registerModule(javaTimeModule);
        response.getWriter().write(objectMapper.writeValueAsString(apiExceptionResponse));
    }
}
