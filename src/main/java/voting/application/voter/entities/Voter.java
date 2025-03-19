
package voting.application.voter.entities;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class Voter {
	
	private int id;
	private String fullName;
	private Date dateOfBirth;
	private String mobile;
	private String aadharNumber;
	private String password;
	private String nationality;
	private boolean authorized;
	private String pwdSalt;
	private String pwdHash;
	private String voterid;
	private MultipartFile profilePic;
	public Voter() {
		super();
	}
	
	public Voter(String fullName, Date dateOfBirth, String mobile, String aadharNumber, String password,
			String nationality, boolean authorized, String pwdSalt, String pwdHash) {
		super();
		this.fullName = fullName;
		this.dateOfBirth = dateOfBirth;
		this.mobile = mobile;
		this.aadharNumber = aadharNumber;
		this.password = password;
		this.nationality = nationality;
		this.authorized = authorized;
		this.pwdSalt = pwdSalt;
		this.pwdHash = pwdHash;
	}
	
	
	public Voter(int id, String fullName, Date dateOfBirth, String mobile, String aadharNumber, String nationality,
			boolean authorized, String pwdSalt, String pwdHash) {
		super();
		this.id = id;
		this.fullName = fullName;
		this.dateOfBirth = dateOfBirth;
		this.mobile = mobile;
		this.aadharNumber = aadharNumber;
		this.nationality = nationality;
		this.authorized = authorized;
		this.pwdSalt = pwdSalt;
		this.pwdHash = pwdHash;
	}
	
	
	
	public Voter(int id, String fullName, Date dateOfBirth, String mobile, String aadharNumber, String nationality,
			boolean authorized, String pwdSalt, String pwdHash, MultipartFile profilePic) {
		super();
		this.id = id;
		this.fullName = fullName;
		this.dateOfBirth = dateOfBirth;
		this.mobile = mobile;
		this.aadharNumber = aadharNumber;
		this.nationality = nationality;
		this.authorized = authorized;
		this.pwdSalt = pwdSalt;
		this.pwdHash = pwdHash;
		this.profilePic = profilePic;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getAadharNumber() {
		return aadharNumber;
	}
	public void setAadharNumber(String aadharNumber) {
		this.aadharNumber = aadharNumber;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNationality() {
		return nationality;
	}
	public void setNationality(String nationality) {
		this.nationality = nationality;
	}
	public boolean isAuthorized() {
		return authorized;
	}
	public void setAuthorized(boolean authorized) {
		this.authorized = authorized;
	}
	public String getPwdSalt() {
		return pwdSalt;
	}
	public void setPwdSalt(String pwdSalt) {
		this.pwdSalt = pwdSalt;
	}
	public String getPwdHash() {
		return pwdHash;
	}
	public void setPwdHash(String pwdHash) {
		this.pwdHash = pwdHash;
	}
	public String getVoterid() {
		return voterid;
	}
	public void setVoterid(String voterid) {
		this.voterid = voterid;
	}
	
	
	
	public MultipartFile getProfilePic() {
		return profilePic;
	}

	public void setProfilePic(MultipartFile profilePic) {
		this.profilePic = profilePic;
	}

	@Override
	public String toString() {
		return "Voter [id=" + id + ", fullName=" + fullName + ", dateOfBirth=" + dateOfBirth + ", mobile=" + mobile
				+ ", aadharNumber=" + aadharNumber + ", password=" + password + ", nationality=" + nationality
				+ ", authorized=" + authorized + ", pwdSalt=" + pwdSalt + ", pwdHash=" + pwdHash + ", profilePic="
				+ profilePic + "]";
	}

	

}
