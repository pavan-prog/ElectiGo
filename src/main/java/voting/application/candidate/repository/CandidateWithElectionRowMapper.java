package voting.application.candidate.repository;

import java.sql.Blob;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import voting.application.candidate.entities.CandidateWithElection;

import org.springframework.web.multipart.MultipartFile;

import voting.application.candidate.entities.ByteArrayMultipartFile;

public class CandidateWithElectionRowMapper implements RowMapper<CandidateWithElection> {

	@Override
    public CandidateWithElection mapRow(ResultSet rs, int rowNum) throws SQLException {
        int id = rs.getInt("candidateId");
        String fullName = rs.getString("full_name");
        Date dateOfBirth = rs.getDate("date_of_birth");
        String nationality = rs.getString("nationality");
        String aadhar = rs.getString("aadhar_number");
        String partyName = rs.getString("party_name");
        Blob image = rs.getBlob("party_logo");
        byte[] imageBytes = image.getBytes(1, (int) image.length());
        MultipartFile partyLogo = new ByteArrayMultipartFile(imageBytes, "image.png", "image/png");
        Boolean isAuthorised = rs.getBoolean("authorized");

     
        int electionId = rs.getInt("electionId");
        String electionName = rs.getString("election_name");
        Date electionDate = rs.getDate("election_start_date");  

        CandidateWithElection candidateWithElection = new CandidateWithElection();
        candidateWithElection.setCandidateId(id);
        candidateWithElection.setFullName(fullName);
        candidateWithElection.setDateOfBirth(dateOfBirth);
        candidateWithElection.setNationality(nationality);
        candidateWithElection.setAadharNumber(aadhar);
        candidateWithElection.setPartyName(partyName);
        candidateWithElection.setPartyLogo(partyLogo);
        candidateWithElection.setAuthorised(isAuthorised);
        
        candidateWithElection.setElectionId(electionId);
        candidateWithElection.setElectionName(electionName);
        candidateWithElection.setElectionDate(electionDate);

        return candidateWithElection;
    }
}