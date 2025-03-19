package voting.application.candidate.repository;

import java.sql.Blob;

import java.sql.Date;
import java.sql.ResultSet;

import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.web.multipart.MultipartFile;

import voting.application.candidate.entities.ByteArrayMultipartFile;
import voting.application.candidate.entities.Candidate;

public class CandidateRowMapper implements RowMapper<Candidate> {

	@Override
	public Candidate mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		
		int id=rs.getInt("_id");
		String fullname=rs.getString("full_name");
		Date dateOfBirth=rs.getDate("date_of_birth");
		String nationality=rs.getString("nationality");
		
		String aadhar=rs.getString("aadhar_number");
		String partyName=rs.getString("party_name");
		Blob image= rs.getBlob("party_logo");
		byte[] imageBytes = image.getBytes(1, (int)image.length());
		
		MultipartFile profileImage = new ByteArrayMultipartFile(imageBytes, "image.png", "image/png");
		Boolean isAuthorised=rs.getBoolean("authorized");
		
		return new Candidate(id,fullname, dateOfBirth, nationality, aadhar, partyName, profileImage, isAuthorised);
	}
	


}
