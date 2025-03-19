package voting.application.election.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import voting.application.candidate.entities.Candidate;
import voting.application.candidate.repository.CandidateDao;
import voting.application.election.entities.Election;
import voting.application.election.repository.ElectionDao;

@Service
public class ElectionServicesImpl implements ElectionServices {

	@Autowired
	ElectionDao electionDao;

	@Autowired
	CandidateDao candidateDao;

	@Override
	public int addNewElection(Election election) {

		return electionDao.insertElection(election);
	}

	@Override
	public List<Election> viewAllElections() {
		return electionDao.getAllElections();
	}

	@Override
	public int removeElection(int id) {
		return electionDao.deleteElection(id);
	}

	@Override
	public int modifyElection(Election election, String electionName) {
		return electionDao.updateElection(election, electionName);
	}

	@Override
	public Election fetchElection(int electionId) {
		return electionDao.getElectionData(electionId);
	}

	@Override
	public List<Integer> getAssignedElectionIds(int subAdminId) {
		return electionDao.findAssignedElectionIdsBySubAdminId(subAdminId);
	}

	@Override
	public List<Election> getAllElections() {
		return electionDao.findAllElections();
	}

	@Override
	public void assignElectionsToSubAdmin(int subAdminId, List<Integer> electionIds) {
		electionDao.deleteAssignedElections(subAdminId);

		if (electionIds != null && !electionIds.isEmpty()) {
			electionDao.insertAssignedElections(subAdminId, electionIds);
		}
	}

	@Override
	public List<Election> getElectionsBySubAdminId(int subAdminId) {
		return electionDao.findElectionsBySubAdminId(subAdminId);
	}

	@Override
	public Election getElectionById(int election_id) {
		return electionDao.findById(election_id);
	}

	@Override
	public List<Election> getUpcomingElections() {
		return electionDao.findUpcomingElections();
	}

	@Override
	public Integer getNominatedElectionId(int candidateId) {
		return electionDao.findNominatedElectionId(candidateId);
	}

	

	@Override
	public void updateNomination(int candidateId, Integer electionId) {
	    if (electionId != null) {
	        Integer currentElectionId = electionDao.findNominatedElectionId(candidateId);

	        System.out.println("Checking the currentElectionId for candidate : " + currentElectionId);
	        
	        	System.out.println("Checking the election id, and candidate id : " + electionId + " ," + candidateId);
	            
	        	electionDao.updateCandidateElection(candidateId, electionId);
	        	
	    }
	}
	
	
	@Override
	public Election findElectionByName(String electionName) {
	    return electionDao.findByName(electionName);
	}



}
