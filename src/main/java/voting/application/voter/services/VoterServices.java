package voting.application.voter.services;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

import javax.sql.rowset.serial.SerialException;

import voting.application.voter.entities.Voter;

public interface VoterServices {

	boolean doesVoterExists(String aadharNumber, String password);

	int registerVoter(Voter voter) throws SerialException, IOException, SQLException;
	
	List<Voter> fetchAllVoters();
	
	Optional<Voter> fetchVoterDetails(String aadharNumber);
	
	boolean getAuthority(int id);

	int deleteVoterById(String aadharNumber);
	
	 int changeVoterAuthority(String aadharNumber);

	 Voter getVoterById(String aadharNumber);
	 
	 boolean isAuthorized(String aadharNumber);

	boolean matchPassword(String password, Voter voter);
	
	
	boolean updateVoter(Voter voter);


	int updateVoterStatus(int voterId, int electionId);
	
	boolean isVoted(int voterId, int electionId);
	
	int updateWinners();
	

}
