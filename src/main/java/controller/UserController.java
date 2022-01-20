package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import beans.Salle;
import beans.User;
import service.SalleService;
import service.UserService;

@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserService us = new UserService();

	private void loadAccounts(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<User> comptes = us.findAccounts();
		Gson json = new Gson();
		response.getWriter().write(json.toJson(comptes));
	}

	private void loadUsers(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<User> users = us.findUsers(Integer.parseInt(request.getSession(false).getAttribute("id").toString()));
		Gson json = new Gson();
		response.getWriter().write(json.toJson(users));
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {

		if (request.getParameter("op") != null) {
			if (request.getParameter("op").equals("loadAccounts")) {
				response.setContentType("application/json");
				loadAccounts(request, response);
				System.out.println("loadAccounts");
			} else if (request.getParameter("op").equals("loadUsers")) {
				response.setContentType("application/json");
				loadUsers(request, response);
				System.out.println("loadAccounts");
			}
			else if (request.getParameter("op").equals("deconnecter")) {
				request.getSession(false).invalidate();
				response.sendRedirect("login.jsp");
			}
			else if (request.getParameter("op").equals("on")) {
				response.setContentType("application/json");
				us.upUser(Integer.parseInt(request.getParameter("id")),1);
				loadUsers(request, response);
			}
			else if (request.getParameter("op").equals("off")) {
				response.setContentType("application/json");
				us.upUser(Integer.parseInt(request.getParameter("id")),-1);
				loadUsers(request, response);
			}
			else if (request.getParameter("op").equals("upUser")) {
				response.setContentType("application/json");
				User user = new User(Integer.parseInt(request.getParameter("id")),
						request.getParameter("nom"), request.getParameter("user"), request.getParameter("pass"),
						(String) request.getSession(false).getAttribute("role"), 1);
				Gson json = new Gson();
				if (us.register(user)) {
					HttpSession session = request.getSession();
					session.setMaxInactiveInterval(10 * 60);
					session.setAttribute("id", user.getId());
					session.setAttribute("user", user.getUsername());
					session.setAttribute("pass", user.getPassword());
					session.setAttribute("role", user.getRole());
					if (user.getRole().equals("Moderateur"))
						session.setAttribute("hidden", "hidden");
					session.setAttribute("nom", user.getNom());
					session.setAttribute("etat", user.getEtat());
					response.getWriter().write(json.toJson("true"));
				}
				else
					response.getWriter().write(json.toJson("false"));
			}
		} else if (request.getParameter("name") == null) {
			User user = us.login(request.getParameter("user"), request.getParameter("pass"));
			if (user != null) {
				HttpSession session = request.getSession();
				session.setMaxInactiveInterval(10 * 60);
				if (user.getEtat() != -1) {
					session.setAttribute("id", user.getId());
					session.setAttribute("user", user.getUsername());
					session.setAttribute("pass", user.getPassword());
					session.setAttribute("role", user.getRole());
					if (user.getRole().equals("Moderateur"))
						session.setAttribute("hidden", "hidden");
					session.setAttribute("nom", user.getNom());
					session.setAttribute("etat", user.getEtat());
					if (user.getEtat() == 0) {
						response.sendRedirect("register.jsp");
						System.out.println("register");
					} else {
						System.out.println("login done");
						response.sendRedirect("index.jsp");
					}
				}
				else
					response.sendRedirect("loginOff.jsp");
			} else {
				System.out.println("no user");
				response.sendRedirect("loginNo.jsp");
			}

		} else if (request.getParameter("name") != null) {
			User user = new User(Integer.parseInt(request.getSession(false).getAttribute("id").toString()),
					request.getParameter("name"), request.getParameter("user"), request.getParameter("pass"),
					(String) request.getSession(false).getAttribute("role"), 1);
			if (us.register(user))
				response.sendRedirect("login.jsp");
		} else {
			response.setContentType("application/json");
			User u = new User("", request.getParameter("user"), request.getParameter("pass"),
					request.getParameter("role"), 0);
			us.createAccount(u);
			loadAccounts(request, response);
			System.out.println("loadAccounts");
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);

	}
}