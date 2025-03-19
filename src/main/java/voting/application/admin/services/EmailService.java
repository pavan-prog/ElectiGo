package voting.application.admin.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendTestEmail() {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("sabhamohammad3009@gmail.com");
        message.setTo("b20ai053@kitsw.ac.in");
        message.setSubject("Test Email");
        message.setText("This is a test email.");
        mailSender.send(message);
    }
}
