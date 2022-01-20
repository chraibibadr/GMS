package service;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import beans.Machine;
import beans.RepGson;
import connexion.Connexion;
import dao.IDao;

public class MachineService implements IDao<Machine> {

	SalleService sc = new SalleService();

	@Override
	public boolean create(Machine o) {
		String sql = "insert into machine values (null, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setString(1, o.getReference());
			ps.setString(2, o.getMarque());
			ps.setDate(3, new Date(o.getDateAchat().getTime()));
			ps.setDouble(4, o.getPrix());
			ps.setInt(5, o.getSalle().getId());
			if (ps.executeUpdate() == 1) {
				return true;
			}
		} catch (SQLException e) {
			System.out.println("create : erreur sql : " + e.getMessage());

		}
		return false;
	}

	@Override
	public boolean delete(Machine o) {
		String sql = "delete from machine where id  = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, o.getId());
			if (ps.executeUpdate() == 1) {
				return true;
			}
		} catch (SQLException e) {
			System.out.println("delete : erreur sql : " + e.getMessage());

		}
		return false;
	}

	@Override
	public boolean update(Machine o) {

		String sql = "update machine set reference  = ? , marque  = ? ,dateAchat = ? , prix = ?, salle  = ? where id  = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setString(1, o.getReference());
			ps.setString(2, o.getMarque());
			ps.setDate(3, new Date(o.getDateAchat().getTime()));
			ps.setDouble(4, o.getPrix());
			ps.setDouble(5, o.getSalle().getId());
			ps.setInt(6, o.getId());
			if (ps.executeUpdate() == 1) {
				return true;
			}
		} catch (SQLException e) {
			System.out.println("update : erreur sql : " + e.getMessage());

		}
		return false;
	}

	@Override
	public Machine findById(int id) {
		String sql = "select * from machine where id  = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return new Machine(rs.getInt("id"), rs.getString("reference"), rs.getString("marque"),
						rs.getDate("dateAchat"), rs.getDouble("prix"), sc.findById(rs.getInt("salle")));
			}

		} catch (SQLException e) {
			System.out.println("findById " + e.getMessage());
		}
		return null;
	}

	@Override
	public List<Machine> findAll() {
		List<Machine> machines = new ArrayList<Machine>();

		String sql = "select * from machine";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				machines.add(new Machine(rs.getInt("id"), rs.getString("reference"), rs.getString("marque"),
						rs.getDate("dateAchat"), rs.getDouble("prix"), sc.findById(rs.getInt("salle"))));
			}

		} catch (SQLException e) {
			System.out.println("findAll " + e.getMessage());
		}
		return machines;
	}

	public List<Machine> findBetweenDates(String d1, String d2) {
		List<Machine> machines = new ArrayList<Machine>();

		String sql = "SELECT * from machine WHERE dateAchat BETWEEN ? AND ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setString(1, d1);
			ps.setString(2, d2);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				machines.add(new Machine(rs.getInt("id"), rs.getString("reference"), rs.getString("marque"),
						rs.getDate("dateAchat"), rs.getDouble("prix"), sc.findById(rs.getInt("salle"))));
			}

		} catch (SQLException e) {
			System.out.println("findBetweenDates " + e.getMessage());
		}
		return machines;
	}

	public List<RepGson> NbrMachineBySalle() {
		List<RepGson> repGsons = new ArrayList<RepGson>();

		String sql = "SELECT COUNT(*) as nbr, s.code FROM machine m INNER JOIN salle s on s.id = m.salle GROUP BY m.salle";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				repGsons.add(new RepGson(rs.getString("code"), rs.getInt("nbr")));
			}
		} catch (SQLException e) {
			System.out.println("NbrMachineBySalle " + e.getMessage());
		}
		return repGsons;
	}

	public List<Machine> findlasts() {
		List<Machine> machines = new ArrayList<Machine>();

		String sql = "SELECT * FROM machine ORDER BY dateAchat DESC LIMIT 5";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				machines.add(new Machine(rs.getInt("id"), rs.getString("reference"), rs.getString("marque"),
						rs.getDate("dateAchat"), rs.getDouble("prix"), sc.findById(rs.getInt("salle"))));
			}

		} catch (SQLException e) {
			System.out.println("findlasts " + e.getMessage());
		}
		return machines;
	}

	public int machineCount() {

		String sql = "SELECT count(*) as nbr from machine";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt("nbr");
			}

		} catch (SQLException e) {
			System.out.println("machineCount " + e.getMessage());
		}
		return 0;
	}

}
