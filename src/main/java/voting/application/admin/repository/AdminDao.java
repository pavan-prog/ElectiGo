package voting.application.admin.repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import voting.application.admin.entities.Admin;

public interface AdminDao{

	int insertAdmin(Admin admin);
	
	Optional<Admin> getAdminData(String username);
	
	List<Admin> getAllAdmins();
	
	List<Admin> getAllAdmins(int roleId);
	
	void changeAuthority(int adminId);	

	Optional<Admin> findAdminById(int adminId);


	public void updateAdminDetails(Admin admin);

    public Optional<Admin> findAdminByEmail(String email);
    
}