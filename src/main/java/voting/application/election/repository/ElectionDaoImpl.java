package voting.application.election.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import voting.application.candidate.entities.Candidate;
import voting.application.candidate.repository.CandidateRowMapper;
import voting.application.election.entities.Election;

@Repository
public class ElectionDaoImpl implements ElectionDao {

	@Autowired
	JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public int insertElection(Election election) {
		final String INSERT_QUERY = "insert into elections(election_name,start_date,end_date) values(?,?,?)";
		return jdbcTemplate.update(INSERT_QUERY, election.getElectionName(), election.getElectionStartDate(),
				election.getElectionEndDate());
	}

	@Override
	public int deleteElection(int id) {
		final String DELETE_QUERY = "DELETE FROM ELECTIONS where _id = ?";

		return jdbcTemplate.update(DELETE_QUERY, id);
	}

	@Override
	public int updateElection(Election election, String electionName) {
		final String UPDATE_QUERY = "UPDATE elections SET election_name = ?, start_date = ?, end_date = ? WHERE election_name = ?";

		return jdbcTemplate.update(UPDATE_QUERY, election.getElectionName(), election.getElectionStartDate(),
				election.getElectionEndDate(), electionName);

	}

	@Override
	public List<Election> getAllElections() {

		final String GET_ALL_ELECTIONS = "SELECT * FROM elections";
		return jdbcTemplate.query(GET_ALL_ELECTIONS, new ElectionRowMapper());
	}

	@Override
	public Election getElectionData(int electionId) {
		final String GET_ELECTION_DATA = "SELECT * FROM elections WHERE _id = ? ";
		return jdbcTemplate.queryForObject(GET_ELECTION_DATA, new ElectionRowMapper(), electionId);

	}


	@Override
	public List<Integer> findAssignedElectionIdsBySubAdminId(int subAdminId) {
		String query = "SELECT election_id FROM election_sub_admin WHERE sub_admin_id = ?";
		return jdbcTemplate.queryForList(query, Integer.class, subAdminId);
	}

	@Override
	public List<Election> findAllElections() {
		String query = "SELECT * FROM elections";
		return jdbcTemplate.query(query, new ElectionRowMapper());
	}

	@Override
	public void deleteAssignedElections(int subAdminId) {
		String query = "DELETE FROM election_sub_admin WHERE sub_admin_id = ?";
		jdbcTemplate.update(query, subAdminId);
	}

	@Override
	public void insertAssignedElections(int subAdminId, List<Integer> electionIds) {
		String query = "INSERT INTO election_sub_admin (sub_admin_id, election_id) VALUES (?, ?)";
		jdbcTemplate.batchUpdate(query, electionIds, electionIds.size(), (ps, electionId) -> {
			ps.setInt(1, subAdminId);
			ps.setInt(2, electionId);
		});
	}

	@Override
	public List<Election> findElectionsBySubAdminId(int subAdminId) {
		String ELECTIONS_ASSIGNED = "SELECT e._id, e.election_name, e.start_date, e.end_date " + "FROM elections e "
				+ "JOIN election_sub_admin esa ON e._id = esa.election_id " + "WHERE esa.sub_admin_id = ?";

		return jdbcTemplate.query(ELECTIONS_ASSIGNED, new ElectionRowMapper(), subAdminId);
	}

	@Override
	public Election findById(int election_id) {
		String query = "SELECT _id, election_name, start_date, end_date FROM elections WHERE _id = ?";
		try {
			return jdbcTemplate.queryForObject(query, new ElectionRowMapper(), election_id);
		} catch (EmptyResultDataAccessException e) {
			throw new IllegalArgumentException("Election not found with ID: " + election_id);
		}
	}

	@Override
	public List<Election> findUpcomingElections() {
		String sql = "SELECT _id, election_name, start_date, end_date FROM elections WHERE CURRENT_DATE <= DATE_SUB(start_date, INTERVAL 2 DAY)";

		return jdbcTemplate.query(sql, new ElectionRowMapper());
	}



	@Override
	public Integer findNominatedElectionId(int candidateId) {
		String sql = "SELECT election_id FROM election_candidate WHERE candidate_id = ?";
		try {
	        return jdbcTemplate.queryForObject(sql, Integer.class, candidateId);
		} catch (EmptyResultDataAccessException e) {
			throw new IllegalArgumentException("candidate not found with ID: " + candidateId);
		}
	}

	@Override
	public void insertNominatedElection(int candidateId, Integer electionId) {
		
		int numberOfVotes = 0;   
	    boolean hasWon = false;   
	    boolean isNominated = true;
	    
		String query = "INSERT INTO election_candidate (candidate_id, election_id, number_of_votes, hasWon, isNominated) VALUES (?, ?, ?, ?, ?)";
	    jdbcTemplate.update(query, candidateId, electionId, numberOfVotes, hasWon, isNominated);
	}
	
	@Override
	public void updateCandidateElection(int candidateId, Integer electionId) {
	    String query = "UPDATE election_candidate SET election_id = ?, number_of_votes = 0, hasWon = false, isNominated = true WHERE candidate_id = ?";
	    int rowsAffected = jdbcTemplate.update(query, electionId, candidateId);
	    
	    if (rowsAffected > 0) {
	        System.out.println("Candidate election updated successfully. candidateId=" + candidateId + ", electionId=" + electionId);
	    } else {
	        System.out.println("Update failed. candidateId=" + candidateId + ", electionId=" + electionId);
	    }	
	    
	}

	
	@Override
	public Election findByName(String electionName) {
        String sql = "SELECT * FROM elections WHERE election_name = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{electionName}, new ElectionRowMapper());
    }
	
}
