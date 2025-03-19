package voting.application.admin.repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import voting.application.admin.entities.Admin;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Autowired
	JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}



	@Override
	public int insertAdmin(Admin admin) {
		final String INSERT_QUERY = "INSERT INTO admin(first_name, last_name, username, email, pwd_salt, pwd_hash, roleId, authorized) VALUES (?,?,?,?,?,?,?,?)";

		return jdbcTemplate.update(INSERT_QUERY, admin.getFirstName(), admin.getLastName(), admin.getUsername(), admin.getEmail(),
				admin.getPwdSalt(), admin.getPwdHash(), admin.getRoleId(), admin.isAuthorized());
	}

	@Override
	public List<Admin> getAllAdmins() {
		final String GET_ALL_ADMINS = "SELECT * FROM admin where roleId = 2";
		return jdbcTemplate.query(GET_ALL_ADMINS, new AdminRowMapper());
	}

	@Override
	public List<Admin> getAllAdmins(int roleId) {

		final String GET_ALL_ADMINS_BY_ROLE = "SELECT * FROM admin where role_id = ?";

		return jdbcTemplate.query(GET_ALL_ADMINS_BY_ROLE, new AdminRowMapper(), roleId);
	}

	@Override
	public Optional<Admin> getAdminData(String username) {

		Admin admin = null;

		final String GET_ADMIN = "SELECT * FROM admin WHERE username = ?";

		try {
			admin = jdbcTemplate.queryForObject(GET_ADMIN, new AdminRowMapper(), username);
		} catch (DataAccessException dataAccessException) {
			dataAccessException.printStackTrace();
		}

		return Optional.ofNullable(admin);
	}

	@Override
	public void changeAuthority(int adminId) {

		final String CHANGE_AUTH = "UPDATE admin SET authorized = !authorized where _id = ?";
		jdbcTemplate.update(CHANGE_AUTH, adminId);
	}
	
	
	
	@Override
	public Optional<Admin> findAdminById(int adminId) {
	    String query = "SELECT * FROM admin WHERE _id = ?";
	    try {
	        return Optional.ofNullable(jdbcTemplate.queryForObject(query, new AdminRowMapper(), adminId));
	    } catch (EmptyResultDataAccessException e) {
	        return Optional.empty();
	    }
	}
	


	@Override
	public void updateAdminDetails(Admin admin) {
	    String sql = "UPDATE admin SET first_name = ?, last_name = ?, username = ?, pwd_salt = ?, pwd_hash = ? WHERE _id = ?";

	    jdbcTemplate.update(sql, admin.getFirstName(), admin.getLastName(), admin.getUsername(), 
	                        admin.getPwdSalt(), admin.getPwdHash(), admin.getId());
	}




    @Override
    public Optional<Admin> findAdminByEmail(String email) {
        Admin admin = null;
        final String GET_ADMIN_BY_EMAIL = "SELECT * FROM admin WHERE email = ?";

        try {
            admin = jdbcTemplate.queryForObject(GET_ADMIN_BY_EMAIL, new AdminRowMapper(), email);
        } catch (EmptyResultDataAccessException e) {
            return Optional.empty();
        } catch (Exception e) {
        	e.printStackTrace();
        }

        return Optional.ofNullable(admin);
    }
	

}