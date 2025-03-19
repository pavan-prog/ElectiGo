package voting.application.admin.services;

import java.util.List;
import java.util.Optional;

import voting.application.admin.entities.Admin;

public interface AdminServices{

	int registerAdmin(Admin admin);

	List<Admin> fetchAllAdmins();

	List<Admin> fetchAllAdmins(int roleId);
	

	Optional<Admin> fetchAdminDetails(String username);
	

	void modifyAuthority(int adminId);

	boolean matchPassword(String password, Admin admin);
	


    Admin getAdminById(int adminId);



    public void updateAdmin(Admin admin);

	public Optional<Admin> fetchAdminDetailsWithEmail(String email);
	
}