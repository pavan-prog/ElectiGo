package voting.application.candidate.services;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import voting.application.admin.entities.Admin;
import voting.application.candidate.entities.Candidate;
import voting.application.candidate.entities.CandidateWithElection;
import voting.application.candidate.repository.CandidateDao;
import voting.application.election.entities.Election;

@Service
public class CandidateServicesImpl implements CandidateServices {

	@Autowired
	CandidateDao candidateDao;

	@Override
	public int registerCandidate(Candidate candidate) throws SerialException, IOException, SQLException {
		if (candidateDao.isAadharExists(candidate.getAadhar_number())) {
			throw new IllegalArgumentException("A candidate with this Aadhar number already exists.");
		}
		return candidateDao.insertCandidate(candidate);
	}

	@Override
	public List<Candidate> fetchAllCandidates() {
		return candidateDao.getAllCustomer();
	}

	@Override
	public Candidate getCandidateByAadhar(String aadhar) {
		return candidateDao.getCandidateByAadhar(aadhar);
	}

	@Override
	public boolean updateCandidate(Candidate candidate) {
		return candidateDao.updateCandidate(candidate);
	}

	@Override
	public int deleteCandidateByAadhar(String aadharNumber) {

		return candidateDao.deleteCandidate(aadharNumber);
	}

	@Override
	public void modifyCandidateAuthority(int candidateId) {
		candidateDao.toggleAuthorization(candidateId);
	}

	@Override
	public boolean linkCandidateToElection(int electionId, Candidate candidate) {
		return candidateDao.insertCandidateIntoElection(electionId, candidate);
	}

	@Override
	public List<CandidateWithElection> getCandidatesWithElectionDetails(int electionId) {
		List<CandidateWithElection> res = candidateDao.findCandidatesWithElectionDetails(electionId);
		return res;
	}
	
	@Override
	public Map<Integer, Integer> fetchVotesForCandidates() {
		return candidateDao.getVotesForCandidates();
	}

	

	@Override
	public Candidate getCandidateById(int candidateId) {
		return candidateDao.findCandidateById(candidateId)
				.orElseThrow(() -> new RuntimeException("Candidate not found with ID: " + candidateId));
	}
	
	

	@Override
	public int getCurrentVotes(int candidateId, int electionId) {
		return candidateDao.fetchCurrentVotes(candidateId, electionId);
	}

	@Override
	public boolean incrementVotesByOne(int electionId, int candidateId) {
		int current_votes = getCurrentVotes(candidateId, electionId);
		return candidateDao.updateVotes(electionId, candidateId, current_votes);
	}

}
