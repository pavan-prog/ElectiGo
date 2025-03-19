package voting.application.auth.services;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
 
import voting.application.admin.entities.Admin;
import voting.application.admin.repository.AdminDao;
import voting.application.utility.Utils;
 
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Optional;
 
@Service
public class AuthServicesImpl implements AuthServices {
 
    @Autowired
    private JavaMailSender mailSender;
 
    @Autowired
    private AdminDao adminDao; 
 
    @Override
    public String generateOtp() {
        String otp = String.valueOf(new Random().nextInt(999999));
        return otp.length() < 6 ? "0" + otp : otp; 
    }
 
    @Override
    public void sendOtpToSubAdmin(String email, String otp) {
    	
        otpStorage.put(email, new OtpDetails(otp, System.currentTimeMillis()));
        System.out.println("Generated OTP: " + otp + " for email: " + email + " at timestamp: " + System.currentTimeMillis());

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("Your OTP for Password Reset");
        message.setText("Your OTP for resetting the password is: " + otp +
                        "\nIt will expire in 1 minute.");
        mailSender.send(message);
    }
 
    @Override
    public Optional<Admin> fetchAdminByEmail(String email) {
        return adminDao.findAdminByEmail(email);
    }
 

    
    @Override
    public boolean verifyOtp(String email, String otp, long timestamp) {
        OtpDetails details = otpStorage.get(email);

        if (details != null) {
            System.out.println("Stored OTP: " + details.otp + ", Provided OTP: " + otp);
            System.out.println("Stored Timestamp: " + details.timestamp + ", Current Time: " + System.currentTimeMillis());
        }

        if (details != null && details.otp.equals(otp)) {
            long expiryTime = 60 * 1000;

            if (System.currentTimeMillis() - details.timestamp <= expiryTime) {
                otpStorage.remove(email); 
                return true;
            }
        }
        return false;
    }
 
    @Override
    public void updatePassword(Admin admin, String newPassword) {
        String newSalt = Utils.generateSalt();
        String hashedPassword = Utils.generatePwdHash(newPassword + newSalt);
 
        admin.setPwdSalt(newSalt);
        admin.setPwdHash(hashedPassword);
 
        adminDao.updateAdminDetails(admin); 
    }
    

    private final ConcurrentHashMap<String, OtpDetails> otpStorage = new ConcurrentHashMap<>();

    private static class OtpDetails {
        String otp;
        long timestamp;

        public OtpDetails(String otp, long timestamp) {
            this.otp = otp;
            this.timestamp = timestamp;
        }
    }
    
}