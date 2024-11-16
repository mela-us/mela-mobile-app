package com.hcmus.mela.security.service;

import com.hcmus.mela.dto.request.RegistrationRequest;
import com.hcmus.mela.dto.response.RegistrationResponse;
import com.hcmus.mela.dto.service.AuthenticatedUserDto;
import com.hcmus.mela.exceptions.custom.RegistrationException;
import com.hcmus.mela.model.postgre.User;
import com.hcmus.mela.model.postgre.UserRole;
import com.hcmus.mela.repository.postgre.UserRepository;
import com.hcmus.mela.security.mapper.UserMapper;
import com.hcmus.mela.utils.ExceptionMessageAccessor;
import com.hcmus.mela.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private static final String REGISTRATION_SUCCESSFUL = "registration_successful";

    private static final String USERNAME_ALREADY_EXISTS = "username_already_exists";

    private final UserRepository userRepository;

    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    private final GeneralMessageAccessor generalMessageAccessor;

    private final ExceptionMessageAccessor exceptionMessageAccessor;

    @Override
    public User findByUsername(String username) {

        return userRepository.findByUsername(username);
    }

    @Override
    public RegistrationResponse registration(RegistrationRequest registrationRequest) {

        final String username = registrationRequest.getUsername();

        final boolean existsByUsername = userRepository.existsByUsername(username);

        if (existsByUsername) {

            log.warn("{} is already being used!", username);

            final String existsUsername = exceptionMessageAccessor.getMessage(null, USERNAME_ALREADY_EXISTS);
            throw new RegistrationException(existsUsername);
        }

        final User user = UserMapper.INSTANCE.convertToUser(registrationRequest);
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setUserRole(UserRole.USER);
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(user.getCreatedAt());

        userRepository.save(user);

        final String registrationSuccessMessage = generalMessageAccessor.getMessage(null, REGISTRATION_SUCCESSFUL, username);

        log.info("{} registered successfully!", username);

        return new RegistrationResponse(registrationSuccessMessage);
    }

    @Override
    public AuthenticatedUserDto findAuthenticatedUserByUsername(String username) {

        final User user = findByUsername(username);

        return UserMapper.INSTANCE.convertToAuthenticatedUserDto(user);
    }

    @Override
    public void updatePassword(String username, String newPassword) {
        User user = this.findByUsername(username);
        if (user != null) {
            user.setPassword(bCryptPasswordEncoder.encode(newPassword));
            user.setUpdatedAt(LocalDateTime.now());
            userRepository.save(user);
        }
    }
}

