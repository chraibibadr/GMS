package beans;

public class User {

	private int id;
    private String nom;
    private String username;
    private String password;
    private String role;
    private int etat;
	
    public User(int id, String nom, String username, String password, String role, int etat) {
		this.id = id;
		this.nom = nom;
		this.username = username;
		this.password = password;
		this.role = role;
		this.etat = etat;
	}
    
    public User(String nom, String username, String password, String role, int etat) {
		this.nom = nom;
		this.username = username;
		this.password = password;
		this.role = role;
		this.etat = etat;
	}

	public int getId() {
		return id;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
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

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public int getEtat() {
		return etat;
	}

	public void setEtat(int etat) {
		this.etat = etat;
	}
    
}
