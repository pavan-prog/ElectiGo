package voting.application.candidate.repository;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.HashMap;
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

import voting.application.admin.entities.Admin;
import voting.application.admin.repository.AdminRowMapper;
import voting.application.candidate.entities.Candidate;
import voting.application.candidate.entities.CandidateWithElection;
import voting.application.election.entities.Election;

@Repository
public class CandidateDaoImpl implements CandidateDao {

	@Autowired
	JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public int insertCandidate(Candidate candidate) throws SerialException, IOException, SQLException {
		final String INSERT_QUERY = "INSERT INTO candidates (full_name,date_of_birth,nationality,aadhar_number,party_name,party_logo,authorized) VALUES(?,?,?,?,?,?,?)";
		MultipartFile image = candidate.getParty_image();

		Blob profileImage = convertToBlob(image);


		jdbcTemplate.update(INSERT_QUERY, candidate.getFull_name(), candidate.getDate_of_birth(),
				candidate.getNationality(), candidate.getAadhar_number(), candidate.getParty_name(), profileImage,
				candidate.isAuthorised());


		final String GET_LAST_INSERTED_ID = "SELECT LAST_INSERT_ID()";
		int candidateId = jdbcTemplate.queryForObject(GET_LAST_INSERTED_ID, Integer.class);

		candidate.set_id(candidateId); 

		return candidateId; 
	}

	private Blob convertToBlob(MultipartFile image) throws IOException, SerialException, SQLException {

		byte[] imageBytes = image.getBytes();

		Blob imageBlob = new SerialBlob(imageBytes);

		return imageBlob;
	}

	@Override
	public List<Candidate> getAllCustomer() {
		final String GET_ALL_CANDIDATES = "SELECT * FROM candidates";
		return jdbcTemplate.query(GET_ALL_CANDIDATES, new CandidateRowMapper());
	}

	@Override
	public Candidate getCandidateByAadhar(String aadhar) {
		final String QUERY = "SELECT * FROM candidates WHERE aadhar_number = ?";
		return jdbcTemplate.queryForObject(QUERY, new Object[] { aadhar }, new CandidateRowMapper());
	}

	@Override
	public boolean updateCandidate(Candidate candidate) {
		final String UPDATE_QUERY = "UPDATE candidates SET full_name = ?, date_of_birth = ?, nationality = ?, party_name = ?, party_logo = ? WHERE aadhar_number = ?";
		MultipartFile image = candidate.getParty_image();
		Blob profileImage = null;

		try {
			profileImage = convertToBlob(image); 
		} catch (Exception e) {
			e.printStackTrace();
		}

		return jdbcTemplate.update(UPDATE_QUERY, candidate.getFull_name(), candidate.getDate_of_birth(),
				candidate.getNationality(), candidate.getParty_name(), profileImage, candidate.getAadhar_number()) > 0;
	}

	@Override
	public int deleteCandidate(String aadharNumber) {
		final String DELETE_QUERY = "DELETE FROM candidates where aadhar_number=?";
		return jdbcTemplate.update(DELETE_QUERY, aadharNumber);
	}

	@Override
	public boolean insertCandidateIntoElection(int electionId, Candidate candidate) {
		final String INSERT_ELECTION_CANDIDATE_QUERY = "INSERT INTO election_candidate (candidate_id, election_id, number_of_votes, hasWon, isNominated) VALUES (?, ?, ?, ?, ?)";

		int candidateId = candidate.get_id();

		return jdbcTemplate.update(INSERT_ELECTION_CANDIDATE_QUERY, candidateId, electionId, 0, false, true) > 0;
	}

	@Override
	public boolean isAadharExists(String aadharNumber) {
		final String QUERY = "SELECT COUNT(*) FROM candidates WHERE aadhar_number = ?";
		Integer count = jdbcTemplate.queryForObject(QUERY, new Object[] { aadharNumber }, Integer.class);
		return count != null && count > 0;
	}

	@Override
	public void toggleAuthorization(int candidateId) {
		final String TOGGLE_AUTH_QUERY = "UPDATE candidates SET authorized = !authorized WHERE _id = ?";
		jdbcTemplate.update(TOGGLE_AUTH_QUERY, candidateId);
	}

	@Override
	public List<CandidateWithElection> findCandidatesWithElectionDetails(int electionId) {
		String sql = "SELECT \r\n" + "    c._id AS candidateId, \r\n" + "    c.full_name, \r\n"
				+ "    c.date_of_birth, \r\n" + "    c.nationality, \r\n" + "    c.aadhar_number, \r\n"
				+ "    c.party_name, \r\n" + "    c.party_logo, \r\n" + "    c.authorized, \r\n"
				+ "    ec.number_of_votes, \r\n" + "    ec.hasWon, \r\n" + "    ec.isNominated, \r\n"
				+ "    e._id AS electionId, \r\n" + "    e.election_name, \r\n"
				+ "    e.start_date AS election_start_date,\r\n" + "    e.end_date AS election_end_date \r\n"
				+ "FROM candidates c \r\n" + "JOIN election_candidate ec ON c._id = ec.candidate_id \r\n"
				+ "JOIN elections e ON ec.election_id = e._id \r\n" + "WHERE e._id = ?";

		return jdbcTemplate.query(sql, new CandidateWithElectionRowMapper(), electionId);

	}

	
	
	@Override
	public Optional<Candidate> findCandidateById(int candidateId) {
	    String query = "SELECT * FROM candidates WHERE _id = ?";
	    try {
	        return Optional.ofNullable(jdbcTemplate.queryForObject(query, new CandidateRowMapper(), candidateId));
	    } catch (EmptyResultDataAccessException e) {
	        return Optional.empty();
	    }
	}
	
	@Override
	public Map<Integer, Integer> getVotesForCandidates() {
		final String QUERY = "SELECT candidate_id, number_of_votes FROM election_candidate";
		return jdbcTemplate.query(QUERY, rs -> {Map<Integer, Integer> votesMap = new HashMap<>();
		while (rs.next()) {
			votesMap.put(rs.getInt("candidate_id"), rs.getInt("number_of_votes"));
			}
		return votesMap;
		});
	}
	
	
	@Override
	public boolean updateVotes(int electionId, int candidateId,int current_votes ) {
	    final String INCREMENT_VOTES_BY_ONE = "update election_candidate set number_of_votes=? where  election_id=? and candidate_id=?";
	    
	    
	    return jdbcTemplate.update(INCREMENT_VOTES_BY_ONE, current_votes+1, electionId, candidateId) > 0;
	}


	@Override
	public int fetchCurrentVotes(int candidateId, int electionId) {
	    final String NO_OF_VOTES_OF_CANDIDATE = "SELECT number_of_votes FROM election_candidate WHERE candidate_id = ? AND election_id = ?";
	    return jdbcTemplate.queryForObject(NO_OF_VOTES_OF_CANDIDATE, new Object[]{candidateId, electionId}, Integer.class);
	}
	
	
}
