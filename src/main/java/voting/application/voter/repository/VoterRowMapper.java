package voting.application.voter.repository;

import java.sql.Blob;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import voting.application.utility.ByteArrayMultipartFile;
import voting.application.voter.entities.Voter;

public class VoterRowMapper implements RowMapper<Voter> {

	@Override
	public Voter mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		
		int id = rs.getInt("_id");
		String fullName = rs.getString("full_name");
		Date dateOfBirth=rs.getDate("date_of_birth");
		String mobile = rs.getString("mobile");
		String pwd_salt = rs.getString("pwd_salt");
		String pwd_hash =  rs.getString("pwd_hash");
		String aadharNumber = rs.getString("aadhar_number");
		String nationality=rs.getString("nationality");
		boolean isAuthorised = rs.getBoolean("authorized");
		Blob profilePic = rs.getBlob("profile_pic");
	
        ByteArrayMultipartFile profileImage = null;

        if (profilePic != null) {
            byte[] imageBytes = profilePic.getBytes(1, (int) profilePic.length());
            profileImage = new ByteArrayMultipartFile(imageBytes, "image.png", "image/png");
        }

        return new Voter(id, fullName, dateOfBirth, mobile, aadharNumber, nationality, isAuthorised, pwd_salt, pwd_hash, profileImage);
    }

}
