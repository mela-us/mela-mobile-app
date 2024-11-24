package com.hcmus.mela.auth.security.utils;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

public class SecurityConstants {
    /**
     * Token Prefix
     * We will use this prefix when parsing JWT Token
     */
    public static final String TOKEN_PREFIX = "Bearer ";

    /**
     * Authorization Prefix in HttpServletRequest
     * Authorization: <type> <credentials>
     * For Example : Authorization: Bearer YWxhZGxa1qea32GVuc2VzYW1l
     */
    public static final String HEADER_STRING = "Authorization";

    public static final String LOGIN_REQUEST_URI = "/login";

    public static final String REGISTRATION_REQUEST_URI = "/register";

    private SecurityConstants() {

        throw new UnsupportedOperationException();
    }

    /**
     * @return authenticated username from Security Context
     */
    public static String getAuthenticatedUsername() {

        final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        final UserDetails userDetails = (UserDetails) authentication.getPrincipal();

        return userDetails.getUsername();
    }

}
