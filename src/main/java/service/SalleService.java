package service;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import beans.Machine;
import beans.Salle;
import connexion.Connexion;
import dao.IDao;

public class SalleService implements IDao<Salle> {

	public boolean create(Salle o) {
        String sql = "insert into Salle values (null, ?, ?)";
        try {
            PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
            ps.setString(1, o.getCode());
            ps.setString(2,o.getType());
            if (ps.executeUpdate() == 1) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println("create : erreur sql : " + e.getMessage());

        }
        return false;
    }

    @Override
    public boolean delete(Salle o) {
        String sql = "delete from Salle where id  = ?";
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
    public boolean update(Salle o) {

        String sql = "update Salle set code = ?, type = ? where id  = ?";
        try {
            PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
            ps.setString(1, o.getCode());
            ps.setString(2, o.getType());
            ps.setInt(3, o.getId());
            if (ps.executeUpdate() == 1) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println("update : erreur sql : " + e.getMessage());

        }
        return false;
    }

    @Override
    public Salle findById(int id) {
        String sql = "select * from Salle where id  = ?";
        try {
            PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Salle(rs.getInt("id"), rs.getString("code"),rs.getString("type"));
            }

        } catch (SQLException e) {
            System.out.println("findById " + e.getMessage());
        }
        return null;
    }

    @Override
    public List<Salle> findAll() {
        List<Salle> Salles = new ArrayList<Salle>();

        String sql = "select * from Salle";
        try {
            PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);;
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Salles.add(new Salle(rs.getInt("id"), rs.getString("code"),rs.getString("type")));
            }

        } catch (SQLException e) {
            System.out.println("findAll " + e.getMessage());
        }
        return Salles;
    }
    
    public List<Machine> findMachines(int id) {
    	List<Machine> machines = new ArrayList<Machine>();
        String sql = "SELECT * from machine WHERE salle = ?";
        try {
            PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
            	machines.add( new Machine(rs.getInt("id"), rs.getString("reference"), rs.getString("marque"),
						rs.getDate("dateAchat"), rs.getDouble("prix"), findById(rs.getInt("salle"))));
            }

        } catch (SQLException e) {
            System.out.println("findMachines " + e.getMessage());
        }
        return machines;
    }
    
    public int salleCount() {

		String sql = "SELECT count(*) as nbr from salle";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt("nbr");
			}

		} catch (SQLException e) {
			System.out.println("salleCount " + e.getMessage());
		}
		return 0;
	}

}
