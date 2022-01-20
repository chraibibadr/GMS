package beans;

import java.util.ArrayList;
import java.util.List;

public class RepGson {
	
	List<Salle> salles = new ArrayList<Salle>();
	List<Machine> machines = new ArrayList<Machine>();
	String code;
	int nbr;
	int nbrMachine;
	int nbrSalle;

	public RepGson(List<Salle> salles, List<Machine> machines) {
		this.salles = salles;
		this.machines = machines;
	}
	
	public RepGson(List<Machine> machines,List<Salle> salles, int nbrMachine, int nbrSalle) {
		this.machines = machines;
		this.salles = salles;
		this.nbrMachine = nbrMachine;
		this.nbrSalle = nbrSalle;
	}
	
	public RepGson(String code, int nbr) {
		this.code = code;
		this.nbr = nbr;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public int getNbr() {
		return nbr;
	}

	public void setNbr(int nbr) {
		this.nbr = nbr;
	}

	public List<Salle> getSalles() {
		return salles;
	}

	public void setSalles(List<Salle> salles) {
		this.salles = salles;
	}

	public List<Machine> getMachines() {
		return machines;
	}

	public void setMachines(List<Machine> machines) {
		this.machines = machines;
	}

}
