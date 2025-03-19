package voting.application.admin.services;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import voting.application.admin.entities.Admin;
import voting.application.admin.repository.AdminDao;
import voting.application.utility.Utils;

@Service
public class AdminServicesImpl implements AdminServices {

	@Autowired
	AdminDao adminDao;
	
	@Override
	public int registerAdmin(Admin admin) {
	    System.out.println("\n Admin data : " + admin);

	    String tempPassword = Utils.generateTempPassword();

	    String pwdSalt = Utils.generateSalt();
	    String modifiedPassword = tempPassword + pwdSalt;

	    String pwdHash = Utils.generatePwdHash(modifiedPassword);

	    admin.setPwdSalt(pwdSalt);
	    admin.setPwdHash(pwdHash);

	    admin.setRoleId(2); 
	    admin.setAuthorized(false);
	    admin.setEmail(admin.getEmail());
	    
	    int result = adminDao.insertAdmin(admin);

	    if (result > 0) {
	        sendTempPasswordToSubAdmin(admin.getEmail(), tempPassword);
	    }

	    return result;
	}

	@Autowired
	private JavaMailSender mailSender;

	private void sendTempPasswordToSubAdmin(String email, String tempPassword) {
	    SimpleMailMessage message = new SimpleMailMessage();
	    message.setTo(email);
	    message.setSubject("Your Temporary Password for Admin Panel");
	    message.setText("Hello,\n\nYour temporary password is: " + tempPassword + 
	                    "\n\nPlease change your password after your first login.\n\nRegards,\nAdmin Team");

	    mailSender.send(message);
	    System.out.println("Temporary password sent to: " + email);
	}


	@Override
	public List<Admin> fetchAllAdmins() {
		return adminDao.getAllAdmins();

	}

	@Override
	public List<Admin> fetchAllAdmins(int roleId) {

		return adminDao.getAllAdmins(roleId);
	}

	@Override
	public Optional<Admin> fetchAdminDetails(String username) {
		return adminDao.getAdminData(username);
	}

	@Override
	public void modifyAuthority(int adminId) {

		adminDao.changeAuthority(adminId);
	}

	@Override
	public boolean matchPassword(String passwordFromUi, Admin admin) {

		String pwdSaltFromDb = admin.getPwdSalt();
		String pwdHashFromDb = admin.getPwdHash();

		String modifiedPassword = passwordFromUi + pwdSaltFromDb;
		String newHash = Utils.generatePwdHash(modifiedPassword);

		return newHash.equals(pwdHashFromDb);
	}
	

	    @Override
	    public Admin getAdminById(int adminId) {
	        return adminDao.findAdminById(adminId)
	                .orElseThrow(() -> new RuntimeException("Admin not found with ID: " + adminId));
	    }
	    
	   
	    
	    @Override
	    public void updateAdmin(Admin admin) {
	        if (admin.getPassword() != null && !admin.getPassword().isEmpty()) {
	            String newSalt = Utils.generateSalt();
	            
	            String modifiedPassword = admin.getPassword() + newSalt;
	            String hashedPassword = Utils.generatePwdHash(modifiedPassword);

	            admin.setPwdSalt(newSalt);
	            admin.setPwdHash(hashedPassword);
	        }
	        
	        adminDao.updateAdminDetails(admin); // Assuming updateAdmin is a method in your DAO to update the admin details
	    }


	    
	    @Override
		public Optional<Admin> fetchAdminDetailsWithEmail(String email) {
			return adminDao.findAdminByEmail(email);
		}
}