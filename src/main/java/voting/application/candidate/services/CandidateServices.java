package voting.application.candidate.services;


import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.sql.rowset.serial.SerialException;

import voting.application.candidate.entities.Candidate;
import voting.application.candidate.entities.CandidateWithElection;
import voting.application.election.entities.Election;

public interface CandidateServices {

	

	int registerCandidate(Candidate candidate) throws SerialException, IOException, SQLException;

	List<Candidate> fetchAllCandidates();
	
	Candidate getCandidateByAadhar(String aadhar);
	 
	boolean updateCandidate(Candidate candidate);

	int deleteCandidateByAadhar(String aadharNumber);
	
	public void modifyCandidateAuthority(int candidateId);

	boolean linkCandidateToElection(int electionId, Candidate candidate);

	public List<CandidateWithElection> getCandidatesWithElectionDetails(int electionId);
	
	
   
	public Candidate getCandidateById(int candidateId);
	
	public Map<Integer, Integer> fetchVotesForCandidates();
	
	public int getCurrentVotes(int candidateId, int electionId);
	
	public boolean incrementVotesByOne(int electionId, int candidateId);
	
}
