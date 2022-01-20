package service;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import beans.Machine;
import beans.User;
import connexion.Connexion;

public class UserService {
	public boolean createAccount(User o) {
		String sql = "insert into users (id, username, password, role, isActive) values (null, ?, ?, ?, 0)";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setString(1, o.getUsername());
			ps.setString(2, o.getPassword());
			ps.setString(3, o.getRole());
			if (ps.executeUpdate() == 1) {
				return true;
			}
		} catch (SQLException e) {
			System.out.println("createAccount : erreur sql : " + e.getMessage());

		}
		return false;
	}
	
	public List<User> findAccounts() {
		List<User> users = new ArrayList<User>();

		String sql = "select * from users where isActive = 0";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				users.add(new User(rs.getInt("id"), rs.getString("name"), rs.getString("username"), rs.getString("password"), rs.getString("role"), rs.getInt("isActive")));
			}

		} catch (SQLException e) {
			System.out.println("findAccounts " + e.getMessage());
		}
		return users;
	}
	
	public List<User> findUsers(int id) {
		List<User> users = new ArrayList<User>();

		String sql = "select * from users where isActive != 0 and id != ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				users.add(new User(rs.getInt("id"), rs.getString("name"), rs.getString("username"), rs.getString("password"), rs.getString("role"), rs.getInt("isActive")));
			}

		} catch (SQLException e) {
			System.out.println("findAccounts " + e.getMessage());
		}
		return users;
	}
	
	public User login(String user, String pass) {
		String sql = "select * from users where username = ? and password = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setString(1, user);
			ps.setString(2, pass);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return new User(rs.getInt("id"), rs.getString("name"), rs.getString("username"), rs.getString("password"), rs.getString("role"), rs.getInt("isActive"));
			}
		} catch (SQLException e) {
			System.out.println("login : erreur sql : " + e.getMessage());

		}
		return null;
	}
	
	public boolean register(User o) {
		String sql = "update users set name = ?, username = ?, password = ?, isActive = 1 where id = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setString(1, o.getNom());
			ps.setString(2, o.getUsername());
			ps.setString(3, o.getPassword());
			ps.setInt(4, o.getId());
			if (ps.executeUpdate() == 1) {
				return true;
			}
		} catch (SQLException e) {
			System.out.println("register : erreur sql : " + e.getMessage());
		}
		return false;
	}
	
	public boolean upUser(int id,int state) {
		String sql = "update users set isActive = ? where id = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, state);
			ps.setInt(2, id);
			if (ps.executeUpdate() == 1) {
				return true;
			}
		} catch (SQLException e) {
			System.out.println("upUser : erreur sql : " + e.getMessage());
		}
		return false;
	}
}
