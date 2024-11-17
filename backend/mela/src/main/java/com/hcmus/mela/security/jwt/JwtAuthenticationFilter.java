package com.hcmus.mela.security.jwt;

import com.hcmus.mela.security.service.TokenStoreService;
import com.hcmus.mela.security.service.UserDetailsServiceImpl;
import com.hcmus.mela.security.utils.SecurityConstants;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.util.Strings;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Service;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Objects;

@Slf4j
@Service
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtTokenManager jwtTokenManager;

    private final UserDetailsServiceImpl userDetailsService;

    private final TokenStoreService tokenStoreService;  // Add TokenStoreService to check blacklist

    @Override
    protected void doFilterInternal(HttpServletRequest request, @NonNull HttpServletResponse response, @NonNull FilterChain chain)
            throws IOException, ServletException {

        final String header = request.getHeader(SecurityConstants.HEADER_STRING);

        String username = null;
        String authToken = null;
        if (Objects.nonNull(header) && header.startsWith(SecurityConstants.TOKEN_PREFIX)) {

            authToken = header.replace(SecurityConstants.TOKEN_PREFIX, Strings.EMPTY);

            try {
                username = jwtTokenManager.getUsernameFromToken(authToken);
            } catch (Exception e) {
                log.error("Authentication Exception : {}", e.getMessage());
                chain.doFilter(request, response);
                return;
            }
        }

        final SecurityContext securityContext = SecurityContextHolder.getContext();

        final boolean canBeStartTokenValidation = Objects.nonNull(username) && Objects.isNull(securityContext.getAuthentication());

        if (!canBeStartTokenValidation) {
            chain.doFilter(request, response);
            return;
        }

        // Check if the token is blacklisted
        if (tokenStoreService.isAccessTokenBlacklisted(authToken)) {
            log.warn("The token is blacklisted. Authentication failed.");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);  // Unauthorized response
            response.getWriter().write("Token is blacklisted");
            return;
        }

        final UserDetails user = userDetailsService.loadUserByUsername(username);
        final boolean validToken = jwtTokenManager.validateToken(authToken, user.getUsername());

        if (!validToken) {
            chain.doFilter(request, response);
            return;
        }

        final UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
        authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        securityContext.setAuthentication(authentication);

        log.info("Authentication successful. Logged in username : {} ", username);

        chain.doFilter(request, response);
    }
}
