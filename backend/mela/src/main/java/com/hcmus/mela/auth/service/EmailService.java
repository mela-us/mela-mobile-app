package com.hcmus.mela.auth.service;

import com.hcmus.mela.auth.dto.dto.EmailDetailsDto;
import com.hcmus.mela.auth.exception.exception.ForgotPasswordException;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EmailService {

    private final JavaMailSender javaMailSender;

    public String generateOtpNotify(String username, String otpCode) {
        return "<html>" +
                "<body>" +
                "<h3 style='color: #4CAF50;'>OTP Verification</h3>" +
                "<p style='font-size: 16px;'>Hello <strong>" + username + "</strong>,</p>" +
                "<p>Your OTP code is: <span style='font-weight: bold; font-size: 20px; color: #f44336;'>" + otpCode + "</span></p>" +
                "<p>This OTP will expire in 5 minutes.</p>" +
                "<p style='font-size: 14px;'>If you did not request this code, please ignore this email.</p>" +
                "<hr>" +
                "<p style='font-size: 12px; color: #888;'>Best regards, <br> MELA</p>" +
                "</body>" +
                "</html>";
    }

    public void sendSimpleMail(EmailDetailsDto details) {
        MimeMessage message = javaMailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setTo(details.getRecipient());
            helper.setSubject(details.getSubject());
            helper.setText(details.getMsgBody(), true);

            javaMailSender.send(message);
        } catch (MessagingException e) {
            throw new ForgotPasswordException("Error while sending mail: " + e.getMessage());
        }
    }
}
