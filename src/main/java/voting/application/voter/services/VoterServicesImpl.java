package voting.application.voter.services;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import voting.application.utility.Utils;
import voting.application.voter.entities.Voter;
import voting.application.voter.repository.VoterDao;

@Service
public class VoterServicesImpl implements VoterServices {

	@Autowired
	VoterDao voterDao;

	@Override
	public int registerVoter(Voter voter) throws SerialException, IOException, SQLException {

		System.out.println("\n voter data :" + voter);

		String pwdSalt = Utils.generateSalt();
		String originalPwd = voter.getPassword();

		String modifiedPassword = originalPwd + pwdSalt;

		String pwdHash = Utils.generatePwdHash(modifiedPassword);

		voter.setPwdSalt(pwdSalt);
		voter.setPwdHash(pwdHash);

		return voterDao.insertVoter(voter);

	}


	
	@Override
	public boolean doesVoterExists(String aadharNumber, String password) {
	    if (!voterDao.isAuthorized(aadharNumber)) {
	        return false; 
	    }

	    Map<String, Object> pwdCredentials = voterDao.getPasswordCredentials(aadharNumber);

	    String pwdSaltFromDb = (String) pwdCredentials.get("pwd_salt");
	    String pwdHashFromDb = (String) pwdCredentials.get("pwd_hash");

	    System.out.println("\n pwdSaltFromDb :" + pwdSaltFromDb);
	    System.out.println("\n pwdHashFromDb :" + pwdHashFromDb);

	    String modifiedPassword = password + pwdSaltFromDb;
	    String newHash = Utils.generatePwdHash(modifiedPassword);

	    return newHash.equals(pwdHashFromDb);
	}
	
	
	

	
	@Override
    public List<Voter> fetchAllVoters() {
        List<Voter> voters = voterDao.getAllVoter();
        return voters.stream()
                     .sorted((v1, v2) -> Integer.compare(v2.getId(), v1.getId()))
                     .collect(Collectors.toList());
    }


	@Override
	public Optional<Voter> fetchVoterDetails(String aadharNumber) {
		return voterDao.getVoterData(aadharNumber);
	}



	@Override
	public boolean getAuthority(int id) {
		
		return voterDao.getAuthority(id);
		
	}
	
	
	@Override
    public int deleteVoterById(String aadharNumber) {
        return voterDao.deleteVoterById(aadharNumber);
    }

	
	 @Override
	    public int changeVoterAuthority(String aadharNumber) {
	        Voter voter = voterDao.findById(aadharNumber);
	        boolean newAuthority = !voter.isAuthorized();
	        return voterDao.changeAuthority(aadharNumber, newAuthority);
	    }

	 @Override
	    public Voter getVoterById(String aadharNumber) {
	        return voterDao.findById(aadharNumber);
	    }

	 @Override
	    public boolean isAuthorized(String aadharNumber) {
	        return voterDao.isAuthorized(aadharNumber);
	    }

	@Override
	public boolean matchPassword(String password, Voter voter) {
		String pwdSaltFromDb = voter.getPwdSalt();
		String pwdHashFromDb = voter.getPwdHash();

		String modifiedPassword = password + pwdSaltFromDb;
		String newHash = Utils.generatePwdHash(modifiedPassword);

		return newHash.equals(pwdHashFromDb);
	}



	@Override
	public int updateVoterStatus(int voterId, int electionId) {

		return voterDao.updateVoterStatus(voterId, electionId);
	}

	@Override
	public boolean isVoted(int voterId, int electionId) {
		return voterDao.isVoted(voterId, electionId);
	}

	@Override
	public int updateWinners() {
		return voterDao.updateHasWon();
	}

	@Override
	public boolean updateVoter(Voter voter) {
		return voterDao.updateVoter(voter);
	}

	
		
	
	
	
}
