package com.hcmus.mela.auth.service;

import com.hcmus.mela.auth.model.UserRole;
import com.hcmus.mela.auth.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Objects;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

    private static final String USERNAME_OR_PASSWORD_INVALID = "Invalid username or password.";

    private final UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) {

        final com.hcmus.mela.auth.model.User user = userRepository.findByUsername(username);

        if (Objects.isNull(user)) {
            throw new UsernameNotFoundException(USERNAME_OR_PASSWORD_INVALID);
        }

        final String authenticatedUsername = user.getUsername();
        final String authenticatedPassword = user.getPassword();
        final UserRole userRole = user.getUserRole();
        final SimpleGrantedAuthority grantedAuthority = new SimpleGrantedAuthority(userRole.name());

        return new org.springframework.security.core.userdetails.User(
                authenticatedUsername,
                authenticatedPassword,
                Collections.singletonList(grantedAuthority));
    }
}
