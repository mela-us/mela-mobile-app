package com.hcmus.mela.controller;

import com.hcmus.mela.repository.UserRepository;
import com.hcmus.mela.security.dto.LoginRequest;
import com.hcmus.mela.security.dto.LoginResponse;
import com.hcmus.mela.security.jwt.JwtTokenService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequiredArgsConstructor
@RequestMapping("/login")
public class LoginController {

	private final JwtTokenService jwtTokenService;

	@PostMapping
	@Operation(tags = "Login Service", description = "You must log in with the correct information to successfully obtain the token information.")
	public ResponseEntity<LoginResponse> loginRequest(@Valid @RequestBody LoginRequest loginRequest) {

		final LoginResponse loginResponse = jwtTokenService.getLoginResponse(loginRequest);

		return ResponseEntity.ok(loginResponse);
	}

	UserRepository userRepository;


	@GetMapping("/test-db-connection")
	public ResponseEntity<String> testDbConnection() {
		try {
			long count = userRepository.count();
			return ResponseEntity.ok("Connected to database. User count: " + count);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("Failed to connect to database: " + e.getMessage());
		}
	}
}
