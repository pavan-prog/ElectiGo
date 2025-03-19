package voting.application.election.entities;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class Election {
	
	SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy/MM/dd");

	private int electionId;
	private String electionName;
	
	
	private Date electionStartDate;
	private Date electionEndDate;
	
	
	public Election() {
		super();
	}

	public Election(int electionId, String electionName, Date electionStartDate, Date electionEndDate) {
		super();
		this.electionId = electionId;
		this.electionName = electionName;
		this.electionStartDate = electionStartDate;
		this.electionEndDate = electionEndDate;
	}

	public Election(String electionName, Date electionStartDate, Date electionEndDate) {
		super();
		this.electionName = electionName;
		this.electionStartDate = electionStartDate;
		this.electionEndDate = electionEndDate;
	}

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

	public Date getElectionStartDate() {
		return electionStartDate;
	}

	public void setElectionStartDate(Date electionStartDate) {
		this.electionStartDate = electionStartDate;
	}

	public Date getElectionEndDate() {
		return electionEndDate;
	}

	public void setElectionEndDate(Date electionEndDate) {
		this.electionEndDate = electionEndDate;
	}

	@Override
	public String toString() {
		return "\nElection [electionId=" + electionId + ", electionName=" + electionName + ", electionStartDate="
				+ electionStartDate + ", electionEndDate=" + electionEndDate + "]";
	}
	
	
}


