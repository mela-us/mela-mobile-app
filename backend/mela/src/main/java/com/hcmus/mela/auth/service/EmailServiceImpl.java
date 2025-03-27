package com.hcmus.mela.auth.service;

import com.hcmus.mela.auth.dto.dto.EmailDetailsDto;
import com.hcmus.mela.auth.exception.ForgotPasswordException;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService{

    @Value("${spring.mail.username}")
    private String mailUsername;

    private final JavaMailSender javaMailSender;

    @Override
    public String generateOtpNotify(String username, String otpCode) {
        return "<html>" +
                "<body>" +
                "<h3 style='color: #4CAF50;'>Xác thực OTP</h3>" +
                "<p style='font-size: 16px;'>Xin chào <strong>" + username + "</strong>,</p>" +
                "<p>Mã OTP của bạn: <span style='font-weight: bold; font-size: 20px; color: #f44336;'>" + otpCode + "</span></p>" +
                "<p>OTP này sẽ mất hiệu lực trong 5 phút.</p>" +
                "<hr>" +
                "<p style='font-size: 12px; color: #888;'>Chân thành, <br> MELA</p>" +
                "</body>" +
                "</html>";
    }

    @Override
    public void sendSimpleMail(EmailDetailsDto details) {
        MimeMessage message = javaMailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setFrom(mailUsername);
            helper.setTo(details.getRecipient());
            helper.setSubject(details.getSubject());
            helper.setText(details.getMsgBody(), true);
        }
        catch (MessagingException e) {
            throw new ForgotPasswordException(e.getMessage());
        }
        javaMailSender.send(message);
    }
}
