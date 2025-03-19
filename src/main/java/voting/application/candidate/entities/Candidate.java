package voting.application.candidate.entities;


import java.sql.Blob;


//import java.sql.Blob;
import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class Candidate {

	private int _id;
	private String full_name;
	private Date date_of_birth;
	private String nationality;
	private String aadhar_number;
	private String party_name;
	private MultipartFile party_image;
	
	private boolean authorised;

	
	public Candidate() {
		super();
	}

	public Candidate(int _id, String full_name, Date date_of_birth, String nationality, String aadhar_number,
			String party_name, MultipartFile party_image, boolean authorised) {
		super();
		this._id = _id;
		this.full_name = full_name;
		this.date_of_birth = date_of_birth;
		this.nationality = nationality;
		this.aadhar_number = aadhar_number;
		this.party_name = party_name;
		this.party_image = party_image;
		this.authorised = authorised;
	}

	public Candidate(String full_name, Date date_of_birth, String nationality, String aadhar_number, String party_name,
			MultipartFile party_image, boolean authorised) {
		super();
		this.full_name = full_name;
		this.date_of_birth = date_of_birth;
		this.nationality = nationality;
		this.aadhar_number = aadhar_number;
		this.party_name = party_name;
		this.party_image = party_image;
		this.authorised = authorised;
	}

	public Candidate(int _id, String full_name, Date date_of_birth, String nationality, String aadhar_number,
			String party_name, boolean authorised) {
		super();
		this._id = _id;
		this.full_name = full_name;
		this.date_of_birth = date_of_birth;
		this.nationality = nationality;
		this.aadhar_number = aadhar_number;
		this.party_name = party_name;
		this.authorised = authorised;
	}

	public int get_id() {
		return _id;
	}

	public void set_id(int _id) {
		this._id = _id;
	}

	public String getFull_name() {
		return full_name;
	}

	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}

	public Date getDate_of_birth() {
		return date_of_birth;
	}

	public void setDate_of_birth(Date date_of_birth) {
		this.date_of_birth = date_of_birth;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public String getAadhar_number() {
		return aadhar_number;
	}

	public void setAadhar_number(String aadhar_number) {
		this.aadhar_number = aadhar_number;
	}

	public String getParty_name() {
		return party_name;
	}

	public void setParty_name(String party_name) {
		this.party_name = party_name;
	}

	public MultipartFile getParty_image() {
		return party_image;
	}

	public void setParty_image(MultipartFile party_image) {
		this.party_image = party_image;
	}

	public boolean isAuthorised() {
		return authorised;
	}

	public void setAuthorised(boolean authorised) {
		this.authorised = authorised;
	}
	
	

	@Override
	public String toString() {
		return "Candidate [_id=" + _id + ", full_name=" + full_name + ", date_of_birth=" + date_of_birth
				+ ", nationality=" + nationality + ", aadhar_number=" + aadhar_number + ", party_name=" + party_name
				+ ", party_image=" + party_image + ", authorised=" + authorised + "]";
	}
	
	
	
	
	
}
