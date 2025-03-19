package voting.application.voter.entities;

public class ElectionCandidates {
	private int candidateId;
	private int electionId;
	private long numberOfVotes;
	private boolean haswon;
	private boolean isNominated;
	public ElectionCandidates() {
		super();
	}
	public ElectionCandidates(int candidateId, int electionId, long numberOfVotes, boolean haswon,
			boolean isNominated) {
		super();
		this.candidateId = candidateId;
		this.electionId = electionId;
		this.numberOfVotes = numberOfVotes;
		this.haswon = haswon;
		this.isNominated = isNominated;
	}
	public int getCandidateId() {
		return candidateId;
	}
	public void setCandidateId(int candidateId) {
		this.candidateId = candidateId;
	}
	public int getElectionId() {
		return electionId;
	}
	public void setElectionId(int electionId) {
		this.electionId = electionId;
	}
	public long getNumberOfVotes() {
		return numberOfVotes;
	}
	public void setNumberOfVotes(long numberOfVotes) {
		this.numberOfVotes = numberOfVotes;
	}
	public boolean isHaswon() {
		return haswon;
	}
	public void setHaswon(boolean haswon) {
		this.haswon = haswon;
	}
	public boolean isNominated() {
		return isNominated;
	}
	public void setNominated(boolean isNominated) {
		this.isNominated = isNominated;
	}
	@Override
	public String toString() {
		return "\nElectionCandidates [candidateId=" + candidateId + ", electionId=" + electionId + ", numberOfVotes="
				+ numberOfVotes + ", haswon=" + haswon + ", isNominated=" + isNominated + "]";
	}
	
	

	
}
