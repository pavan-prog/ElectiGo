package voting.application.admin.entities;

public class Admin {

	private int id;
	private String firstName;
	private String lastName;
	private String username;
	private String password;

    private String email; 

	private String pwdSalt;
	private String pwdHash;
	private int roleId;
	private boolean authorized; 

	public Admin() {
		super();
	}
	
	

	public Admin(int id, String firstName, String lastName, String username, String email, String pwdSalt,
			String pwdHash, int roleId, boolean authorized) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.email = email;
		this.pwdSalt = pwdSalt;
		this.pwdHash = pwdHash;
		this.roleId = roleId;
		this.authorized = authorized;
	}



	public Admin(String firstName, String lastName, String username, String email,
										String pwdSalt, String pwdHash, int roleId, boolean authorized) {
									super();
									this.firstName = firstName;
									this.lastName = lastName;
									this.username = username;
									this.email = email;
									this.pwdSalt = pwdSalt;
									this.pwdHash = pwdHash;
									this.roleId = roleId;
									this.authorized = authorized;
								}



	public Admin(int id, String firstName, String lastName, String username,
										String password, String email, String pwdSalt, String pwdHash, int roleId,
										boolean authorized) {
									super();
									this.id = id;
									this.firstName = firstName;
									this.lastName = lastName;
									this.username = username;
									this.password = password;
									this.email = email;
									this.pwdSalt = pwdSalt;
									this.pwdHash = pwdHash;
									this.roleId = roleId;
									this.authorized = authorized;
								}



	public Admin(int id, String firstName, String lastName, String username, String pwdSalt, String pwdHash, int roleId,
			boolean authorized) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.pwdSalt = pwdSalt;
		this.pwdHash = pwdHash;
		this.roleId = roleId;
		this.authorized = authorized;
	}

	public Admin(String firstName, String lastName, String username, int roleId, boolean authorized, String pwdSalt,
			String pwdHash) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.password = password;
		this.roleId = roleId;
		this.authorized = authorized;
		this.pwdSalt = pwdSalt;
		this.pwdHash = pwdHash;
	}

	public Admin(int id, String firstName, String lastName, String username, int roleId, boolean authorized,
			String pwdSalt, String pwdHash) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.password = password;
		this.roleId = roleId;
		this.authorized = authorized;
		this.pwdSalt = pwdSalt;
		this.pwdHash = pwdHash;
	}

	// for fetchAllAdmins

	public Admin(String firstName, String lastName, String username, boolean authorized) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.authorized = authorized;
	}

	public Admin(int id, String firstName, String lastName, String username, boolean authorized) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.authorized = authorized;
	}

	public Admin(int id, String firstName, String lastName, String username, String password) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.password = password;
	}

	public Admin(String firstName, String lastName, String username, String password, int roleId, boolean authorized) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.password = password;
		this.roleId = roleId;
		this.authorized = authorized;
	}

	public Admin(int id, String firstName, String lastName, String username, String password, int roleId,
			boolean authorized) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.password = password;
		this.roleId = roleId;
		this.authorized = authorized;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
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
	
	

	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	@Override
	public String toString() {
		return "\n Admin [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", username=" + username
				+ ", password=" + password + ", roleId=" + roleId + ", authorized=" + authorized + ", pwdSalt="
				+ pwdSalt + ", pwdHash=" + pwdHash + "]";
	}

}