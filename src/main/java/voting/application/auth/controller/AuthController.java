package voting.application.auth.controller;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
 
import voting.application.admin.entities.Admin;
import voting.application.auth.services.AuthServicesImpl;
 
import java.util.Optional;
@Controller
@RequestMapping("/auth")
public class AuthController {
 
    @Autowired
    private AuthServicesImpl authServices;
 
    @GetMapping("/forgot_password_page")
    public String openForgotPasswordPage(Model model) {
        model.addAttribute("step", "email"); 
        return "auth/reset_password_combined";
    }
 
    @PostMapping("/forgot_password")
    public String forgotPassword(@RequestParam String email, Model model) {
        Optional<Admin> admin = authServices.fetchAdminByEmail(email);
        if (admin.isPresent()) {
            String otp = authServices.generateOtp();
            authServices.sendOtpToSubAdmin(email, otp);  
            model.addAttribute("email", email);
            model.addAttribute("timestamp", System.currentTimeMillis());
            model.addAttribute("step", "otp"); 
            return "auth/reset_password_combined"; 
        } else {
            model.addAttribute("error", "Email not found.");
            model.addAttribute("step", "email");
            return "auth/reset_password_combined";
        }
    }
 
    @PostMapping("/verify_otp")
    public String verifyOtp(@RequestParam String email, @RequestParam String otp, Model model) {
        boolean isVerified = authServices.verifyOtp(email, otp, System.currentTimeMillis());
        if (isVerified) {
            model.addAttribute("email", email);
            model.addAttribute("step", "resetPassword"); 
            return "auth/reset_password_combined";
        } else {
            model.addAttribute("error", "Invalid OTP or OTP expired.");
            model.addAttribute("email", email); 
            model.addAttribute("step", "otp"); 
            return "auth/reset_password_combined";
        }
    }
 
    @PostMapping("/change_password")
    public String changePassword(@RequestParam String email, @RequestParam String newPassword, @RequestParam String confirmPassword, Model model) {
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match.");
            model.addAttribute("email", email);
            model.addAttribute("step", "resetPassword");
            return "auth/reset_password_combined";
        }
 
        Optional<Admin> admin = authServices.fetchAdminByEmail(email);
        if (admin.isPresent()) {
            authServices.updatePassword(admin.get(), newPassword);
            model.addAttribute("success", "Password updated successfully.");
            return "admin/login"; 
        } else {
            model.addAttribute("error", "Email not found.");
            model.addAttribute("email", email);
            model.addAttribute("step", "resetPassword");
            return "auth/reset_password_combined";
        }
    }
}