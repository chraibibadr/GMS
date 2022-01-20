import beans.Machine;
import beans.Salle;
import service.MachineService;
import service.SalleService;

public class Test {

	public static void main(String[] args) {
		MachineService ms = new MachineService();
		for(Machine m : ms.findAll()) {
			System.out.println(m.getReference());
		}
		
		SalleService sc = new SalleService();
		for(Salle s : sc.findAll()) {
			System.out.println(s.getCode());
		}
	}
}
