package voting.application.candidate.repository;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.sql.rowset.serial.SerialException;

import voting.application.candidate.entities.Candidate;
import voting.application.candidate.entities.CandidateWithElection;
import voting.application.election.entities.Election;

public interface CandidateDao {

	int insertCandidate(Candidate candidate) throws SerialException, IOException, SQLException;

	List<Candidate> getAllCustomer();
	
	Candidate getCandidateByAadhar(String aadhar);
	 
	boolean updateCandidate(Candidate candidate);

	int deleteCandidate(String aadharNumber);

	boolean insertCandidateIntoElection(int electionId, Candidate candidate);

	public boolean isAadharExists(String aadharNumber);
	
	public void toggleAuthorization(int candidateId);

	public List<CandidateWithElection> findCandidatesWithElectionDetails(int electionId);
	

	public Optional<Candidate> findCandidateById(int candidateId);
	
	public Map<Integer, Integer> getVotesForCandidates();
	
	public boolean updateVotes(int electionId, int candidateId,int current_votes );
	
	public int fetchCurrentVotes(int candidateId, int electionId);
}

