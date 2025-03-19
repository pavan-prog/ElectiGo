package voting.application.voter.repository;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import voting.application.voter.entities.Voter;

@Repository
public class VoterDaoImpl implements VoterDao {

	@Autowired
	JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public int insertVoter(Voter voter)throws IOException, SerialException, SQLException {


		MultipartFile image = voter.getProfilePic();
		Blob profileImage = convertToBlob(image);
		
		final String INSERT_QUERY = "INSERT INTO voter"
				+ "(full_name, date_of_birth, mobile, aadhar_number,nationality,pwd_salt,pwd_hash,profile_pic)"
				+ " VALUES(?,?,?,?,?,?,?,?)";

		return jdbcTemplate.update(INSERT_QUERY, voter.getFullName(), voter.getDateOfBirth(), voter.getMobile(),
				voter.getAadharNumber(), voter.getNationality(), voter.getPwdSalt(), voter.getPwdHash(),profileImage);
	}
	
	private Blob convertToBlob(MultipartFile image) throws IOException, SerialException, SQLException {

		byte[] imageBytes = image.getBytes();

		Blob imageblob = new SerialBlob(imageBytes);

		return imageblob;
	}


	@Override
	public Map<String, Object> getPasswordCredentials(String aadhar_number) {

		final String GET_PWD_CREDENTIALS = "SELECT pwd_salt,pwd_hash FROM voter WHERE aadhar_number=?";

		return jdbcTemplate.queryForMap(GET_PWD_CREDENTIALS, aadhar_number);
	}

	@Override
	public List<Voter> getAllVoter() {
		final String GET_ALL_VOTERS = "SELECT * FROM voter";
		return jdbcTemplate.query(GET_ALL_VOTERS, new VoterRowMapper());

	}

	@Override
	public Optional<Voter> getVoterData(String aadharNumber) {

		Voter voter=null;
		final String GET_VOTER = "SELECT * FROM voter WHERE aadhar_number= ? ";

		try {
			voter = jdbcTemplate.queryForObject(GET_VOTER, new VoterRowMapper(), aadharNumber);
		} catch (DataAccessException dataAccessException) {
			dataAccessException.printStackTrace();
		}

		return Optional.ofNullable(voter);
	}



	@Override
	public boolean getAuthority(int id) {
		final String GET_AUTH = "SELECT authorized FROM customer WHERE id = ?";
		return jdbcTemplate.queryForObject(GET_AUTH, Boolean.class, id);
	}

	@Override
	public int deleteVoterById(String aadharNumber) {
		String DELETE_VOTER = "DELETE FROM voter WHERE aadhar_number = ?";
        return jdbcTemplate.update(DELETE_VOTER, aadharNumber);
    }


	@Override
    public int changeAuthority(String aadharNumber, boolean isAuthorized) {
        String CHANGE_AUTH = "UPDATE voter SET authorized = ? WHERE aadhar_number = ?";
        return jdbcTemplate.update(CHANGE_AUTH, isAuthorized, aadharNumber);
    }


	@Override
    public Voter findById(String aadharNumber) {
        String FIND_BY_ID = "SELECT * FROM voter WHERE aadhar_number = ?";
        
       
        return jdbcTemplate.queryForObject(FIND_BY_ID, new VoterRowMapper(), aadharNumber);
   
        
    }

	 @Override
	    public boolean isAuthorized(String aadharNumber) {
	        String CHECK_AUTHORIZED = "SELECT authorized FROM voter WHERE aadhar_number = ?";
	        return jdbcTemplate.queryForObject(CHECK_AUTHORIZED, Boolean.class, aadharNumber);
	    }

	 
	 @Override
		public boolean updateVoter(Voter voter) {

		 final String UPDATE_VOTER = "UPDATE voter SET full_name = ?, date_of_birth = ?, mobile = ? WHERE aadhar_number = ?";
	        return jdbcTemplate.update(UPDATE_VOTER, voter.getFullName(), voter.getDateOfBirth(), voter.getMobile(), voter.getAadharNumber())>0;

		 
		}
	 

	@Override
	public int updateVoterStatus(int voterId, int electionId) {
		final String UPDATE_VOTER_STATUS = "insert into elections_vote(voter_id,election_id,is_voted) values(?,?,?)";
        return jdbcTemplate.update(UPDATE_VOTER_STATUS,voterId,electionId,1);
	}

	@Override
	public boolean isVoted(int voterId, int electionId) {
	    final String FETCH_IS_VOTED = "SELECT is_voted FROM elections_vote WHERE voter_id = ? AND election_id = ?";
	    try {
	        return jdbcTemplate.queryForObject(FETCH_IS_VOTED, Boolean.class, voterId, electionId);
	    } catch (EmptyResultDataAccessException e) {
	        return false;
	    }
	}
		


	 @Override
		public int updateHasWon() {
		 
		 
		 final String UPDATE_HAS_WON = "UPDATE election_candidate ec\r\n"
		 		+ "JOIN (\r\n"
		 		+ "    SELECT election_id, candidate_id\r\n"
		 		+ "    FROM (\r\n"
		 		+ "        SELECT election_id, candidate_id,\r\n"
		 		+ "               DENSE_RANK() OVER (PARTITION BY election_id ORDER BY number_of_votes DESC) AS dr\r\n"
		 		+ "        FROM election_candidate\r\n"
		 		+ "        WHERE election_id IN (\r\n"
		 		+ "            SELECT _id\r\n"
		 		+ "            FROM elections\r\n"
		 		+ "            WHERE end_date < CURDATE()\r\n"
		 		+ "        )\r\n"
		 		+ "    ) ranked\r\n"
		 		+ "    WHERE dr = 1\r\n"
		 		+ ") winners\r\n"
		 		+ "ON ec.election_id = winners.election_id AND ec.candidate_id = winners.candidate_id\r\n"
		 		+ "SET ec.hasWon = 1\r\n"
		 		+ "WHERE ec.election_id IN (\r\n"
		 		+ "    SELECT _id\r\n"
		 		+ "    FROM elections\r\n"
		 		+ "    WHERE end_date < CURDATE()\r\n"
		 		+ ");";
	        return jdbcTemplate.update(UPDATE_HAS_WON);
	    }

	
}
