package voting.application.voter.repository;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.sql.rowset.serial.SerialException;

import voting.application.voter.entities.Voter;

public interface VoterDao {
	
	int insertVoter(Voter voter) throws IOException, SerialException, SQLException;
	
	Map<String,Object> getPasswordCredentials(String username);

	List<Voter> getAllVoter();
	
	Optional<Voter> getVoterData(String aadharNumber);
	
	
	boolean getAuthority(int id);

	int deleteVoterById(String aadharNumber); 
	
	int changeAuthority(String aadharNumber,boolean isAuthorized);

	Voter findById(String aadharNumber);
	
    boolean isAuthorized(String aadharNumber);

    
    boolean updateVoter(Voter voter);
    
    int updateVoterStatus(int voterId, int electionId);

	boolean isVoted(int voterId, int electionId);
    
	public int updateHasWon();
    
}
