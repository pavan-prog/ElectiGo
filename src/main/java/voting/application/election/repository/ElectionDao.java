package voting.application.election.repository;

import java.util.List;
import java.util.Optional;

import voting.application.candidate.entities.Candidate;
import voting.application.election.entities.Election;

public interface ElectionDao {

	int insertElection(Election election);
	int deleteElection(int id);
	int updateElection(Election election,String electionName);
	List<Election> getAllElections();
	Election getElectionData(int electionId);

	
	public List<Integer> findAssignedElectionIdsBySubAdminId(int subAdminId);
	
	public List<Election> findAllElections();
	
	public void deleteAssignedElections(int subAdminId);
	public void insertAssignedElections(int subAdminId, List<Integer> electionIds);
	
	public List<Election> findElectionsBySubAdminId(int subAdminId);
	
	public Election findById(int id);
	
	public List<Election> findUpcomingElections();
	
	public Integer findNominatedElectionId(int candidateId);
	
	public void insertNominatedElection(int candidateId, Integer electionId);
	public void updateCandidateElection(int candidateId, Integer electionId);
	public Election findByName(String electionName);
}
