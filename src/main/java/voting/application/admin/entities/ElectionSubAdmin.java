package voting.application.admin.entities;

public class ElectionSubAdmin {

	private int subAdminId;
	private int electionId;

	public ElectionSubAdmin() {
		super();
	}

	public ElectionSubAdmin(int subAdminId, int electionId) {
		super();
		this.subAdminId = subAdminId;
		this.electionId = electionId;
	}

	public ElectionSubAdmin(int id, int subAdminId, int electionId) {
		super();
		this.subAdminId = subAdminId;
		this.electionId = electionId;
	}



	public int getSubAdminId() {
		return subAdminId;
	}

	public void setSubAdminId(int subAdminId) {
		this.subAdminId = subAdminId;
	}

	public int getElectionId() {
		return electionId;
	}

	public void setElectionId(int electionId) {
		this.electionId = electionId;
	}

	@Override
	public String toString() {
		return "\nElectionSubAdmin [subAdminId=" + subAdminId + ", electionId=" + electionId + "]";
	}

}
