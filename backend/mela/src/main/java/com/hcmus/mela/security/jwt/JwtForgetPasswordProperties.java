package com.hcmus.mela.security.jwt;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Getter
@Setter
@Configuration
@ConfigurationProperties(prefix = "forget.pw")
public class JwtForgetPasswordProperties {

	private String issuer;

	private String secretKey;

	private long expirationMinute;

}
