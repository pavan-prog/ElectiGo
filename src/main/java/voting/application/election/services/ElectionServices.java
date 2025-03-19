package voting.application.election.services;

import java.util.List;
import java.util.Optional;

import voting.application.candidate.entities.Candidate;
import voting.application.election.entities.Election;

public interface ElectionServices {

	int addNewElection(Election election);
	int modifyElection(Election election, String electionName);
	int removeElection(int id);
	List<Election> viewAllElections();
	Election fetchElection(int electionId);

	
	public List<Integer> getAssignedElectionIds(int subAdminId);
	
	public List<Election> getAllElections();
	
	public void assignElectionsToSubAdmin(int subAdminId, List<Integer> electionIds);

	public List<Election> getElectionsBySubAdminId(int subAdminId);


	public Election getElectionById(int election_id);

	public List<Election> getUpcomingElections();
	
  
    
    
	public Integer getNominatedElectionId(int candidateId);

	public void updateNomination(int candidateId, Integer electionId);
	
	
	public Election findElectionByName(String electionName);
}
