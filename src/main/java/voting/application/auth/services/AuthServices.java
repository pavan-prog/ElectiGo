package voting.application.auth.services;

import java.util.Optional;

import voting.application.admin.entities.Admin;

public interface AuthServices {

    public String generateOtp();
    
    public void sendOtpToSubAdmin(String email, String otp);
    
    public Optional<Admin> fetchAdminByEmail(String email);
    
    public boolean verifyOtp(String email, String otp, long timestamp);
    
    public void updatePassword(Admin admin, String newPassword);    
}
