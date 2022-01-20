package controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import beans.Machine;
import beans.RepGson;
import beans.Salle;
import service.MachineService;
import service.SalleService;

@WebServlet("/MachineController")
public class MachineController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	SalleService ss = new SalleService();
	MachineService ms = new MachineService();
    
	private void load(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
        List<Machine> machines = ms.findAll();
        List<Salle> salles = ss.findAll();
        Gson json = new Gson();
        RepGson rg = new RepGson(salles, machines);
        response.getWriter().write(json.toJson(rg));
	}
	
    @SuppressWarnings("deprecation")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
		 
    	if (request.getParameter("op") != null) {
            if (request.getParameter("op").equals("load")) {
            	response.setContentType("application/json");
                load(request, response);
                System.out.println("load");
            }
            else if(request.getParameter("op").equals("loadHome"))
            {
            	response.setContentType("application/json");
            	List<Machine> machines = ms.findlasts();
            	List<Salle> salles = ss.findAll();
                Gson json = new Gson();
                RepGson repGson = new RepGson(machines,salles,ms.machineCount(),ss.salleCount());
                response.getWriter().write(json.toJson(repGson));
                System.out.println("loadHome");
            }
            else if (request.getParameter("op").equals("update")) {
                response.setContentType("application/json");
                Machine m = ms.findById(Integer.parseInt(request.getParameter("idMachine")));
                m.setReference(request.getParameter("ref"));
                m.setMarque(request.getParameter("marque"));
                m.setPrix(Double.parseDouble(request.getParameter("prix")));
                m.setDateAchat(new Date(request.getParameter("dateAchat").replace("-", "/")));
                m.setSalle(ss.findById(Integer.parseInt(request.getParameter("salle"))));
                ms.update(m);
                load(request, response);
                System.out.println("update");
            }
            else if (request.getParameter("op").equals("delete")) {
                response.setContentType("application/json");
                ms.delete(ms.findById(Integer.parseInt(request.getParameter("idMachine"))));
                load(request, response);
                System.out.println("dalete");
            }
            else if(request.getParameter("op").equals("loadMachinesD"))
            {
            	response.setContentType("application/json");
            	List<Machine> machines = ms.findBetweenDates(request.getParameter("d1").replace("-", "/"),request.getParameter("d2").replace("-", "/"));
                Gson json = new Gson();
                response.getWriter().write(json.toJson(machines));
                System.out.println("loadMachinesD");
            }
            else if(request.getParameter("op").equals("charts"))
            {
            	response.setContentType("application/json");
            	List<RepGson> chart = ms.NbrMachineBySalle();
                Gson json = new Gson();
                response.getWriter().write(json.toJson(chart));
                System.out.println("charts");
            }
        }
    	else
    	{
    		response.setContentType("application/json");
            ms.create(new Machine(request.getParameter("ref"),
            		request.getParameter("marque"),
            		new Date(request.getParameter("dateAchat").replace("-", "/")),
            		Double.parseDouble(request.getParameter("prix")),
            		ss.findById(Integer.parseInt(request.getParameter("salle")))));
            load(request, response);
            System.out.println("add");
    	}
	 }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);

	}

}