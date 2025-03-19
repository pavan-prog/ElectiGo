package voting.application.admin.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import voting.application.admin.entities.Admin;


public class AdminRowMapper implements RowMapper<Admin>{

	@Override
	public Admin mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		
		int id = rs.getInt("_id");
		String firstName = rs.getString("first_name");
		String lastName = rs.getString("last_name");
		String username = rs.getString("username");
		String email = rs.getString("email");
		String pwd_salt = rs.getString("pwd_salt");
		String pwd_hash = rs.getString("pwd_hash");
		int roleId = rs.getInt("roleId");
		boolean authorized = rs.getBoolean("authorized");
		
		
		return new Admin(id, firstName, lastName, username, email, pwd_salt, pwd_hash, roleId, authorized);
	}

}
