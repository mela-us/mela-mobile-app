package com.hcmus.mela.service;

import com.hcmus.mela.dto.service.EmailDetails;

public interface EmailService {
    public void sendSimpleMail(EmailDetails details);
}
