package voting.application.candidate.entities;

import java.sql.Date;
import org.springframework.web.multipart.MultipartFile;

public class CandidateWithElection {

	private int candidateId;
	private String fullName;
	private Date dateOfBirth;
	private String nationality;
	private String aadharNumber;
	private String partyName;
	private MultipartFile partyLogo;
	private Boolean authorised;

	private int electionId;
	private String electionName;
	private Date electionDate;

	private int numberOfVotes;

	public CandidateWithElection() {
		super();
	}

	public CandidateWithElection(int candidateId, String fullName, Date dateOfBirth, String nationality,
			String aadharNumber, String partyName, MultipartFile partyLogo, Boolean authorised, int electionId,
			String electionName, Date electionDate) {
		super();
		this.candidateId = candidateId;
		this.fullName = fullName;
		this.dateOfBirth = dateOfBirth;
		this.nationality = nationality;
		this.aadharNumber = aadharNumber;
		this.partyName = partyName;
		this.partyLogo = partyLogo;
		this.authorised = authorised;
		this.electionId = electionId;
		this.electionName = electionName;
		this.electionDate = electionDate;
	}

	public int getCandidateId() {
		return candidateId;
	}

	public void setCandidateId(int candidateId) {
		this.candidateId = candidateId;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public String getAadharNumber() {
		return aadharNumber;
	}

	public void setAadharNumber(String aadharNumber) {
		this.aadharNumber = aadharNumber;
	}

	public String getPartyName() {
		return partyName;
	}

	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}

	public MultipartFile getPartyLogo() {
		return partyLogo;
	}

	public void setPartyLogo(MultipartFile partyLogo) {
		this.partyLogo = partyLogo;
	}

	public Boolean getAuthorised() {
		return authorised;
	}

	public void setAuthorised(Boolean authorised) {
		this.authorised = authorised;
	}

	// Election fields getters and setters
	public int getElectionId() {
		return electionId;
	}

	public void setElectionId(int electionId) {
		this.electionId = electionId;
	}

	public String getElectionName() {
		return electionName;
	}

	public void setElectionName(String electionName) {
		this.electionName = electionName;
	}

	public Date getElectionDate() {
		return electionDate;
	}

	public void setElectionDate(Date electionDate) {
		this.electionDate = electionDate;
	}

	public int getNumberOfVotes() {
		return numberOfVotes;
	}

	public void setNumberOfVotes(int numberOfVotes) {
		this.numberOfVotes = numberOfVotes;
	}

	@Override
	public String toString() {
		return "CandidateWithElection [candidateId=" + candidateId + ", fullName=" + fullName + ", dateOfBirth="
				+ dateOfBirth + ", nationality=" + nationality + ", aadharNumber=" + aadharNumber + ", partyName="
				+ partyName + ", partyLogo=" + partyLogo + ", authorised=" + authorised + ", electionId=" + electionId
				+ ", electionName=" + electionName + ", electionDate=" + electionDate + "]";
	}

}
