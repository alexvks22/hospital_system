package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.postgresql.util.PSQLException;

import ask_1.src.lab_ask1.*;

/**
 * Servlet implementation class InsertServlet
 */
@WebServlet("/insertservlet")
public class InsertServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
	private DataSource datasource = null;
	
	public void init() throws ServletException{
	  try {
	 
	   InitialContext ctx = new InitialContext();
	   datasource = (DataSource)ctx.lookup("java:comp/env/jdbc/LiveDataSource");
	  } catch(Exception e) {
	   throw new ServletException(e.toString());
	  }

	 }
	 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		

	     String submit = request.getParameter("submit");
    	  String sql=null;
    	  
	       if (submit.equals("Submit Doctor"))  //admin accepts registration of doctor
	       { 
	    	   String[] results = request.getParameterValues("test");

		      for (int i =0; i<results.length;i++)
		      {
		    	  
		    	  long doctorAMKA = Long.parseLong(results[i]);
		    	  String insert_query = "insert into doctor (doctorAMKA, username, password, name, surname, specialty) select doctorAMKA, username, password, name, surname, specialty from pending where doctorAMKA=?";
		    	  String delete_query = "delete from pending where doctorAMKA=?";	  
		    	  Admin.insert_and_delete_from_pending(doctorAMKA,insert_query,delete_query);
		    		
		      }
		      response.sendRedirect("/Java_dyn_project/jsp_files/admin.jsp");
	          	        
	       }
	       
		      
		      if (submit.equals("Submit Patient")) //admin accept registration of patient
		      {

		        	String[] results = request.getParameterValues("test2");
		        
		       
		    	   for (int i =0; i< results.length; i++)
		        {
		        	long patientAMKA = Long.parseLong(results[i]);
		        	String insert_sql = "insert into patient(patientAMKA, userid, password, name, surname, gender) select patientAMKA, userid, password, name, surname, gender from pending_pat where patientAMKA=?";
		        	String delete_sql = "delete from pending_pat where patientAMKA=?";
		        	Admin.insert_and_delete_from_pending(patientAMKA, insert_sql, delete_sql);
		        }
		    	   
		       
		        

			      response.sendRedirect("/Java_dyn_project/jsp_files/admin.jsp");
		      }
		      
		      if (submit.equals("Delete Doctor"))  //admin deletes registered doctor
		      {

			        String[] results = request.getParameterValues("test3");
			        
			        for (int i =0; i< results.length; i++)
			        {
			        	long doctorAMKA = Long.parseLong(results[i]);
			        	sql = "delete from doctor where doctorAMKA=?";
			        	Admin.delete(doctorAMKA, sql);
			        }

				      response.sendRedirect("/Java_dyn_project/jsp_files/admin.jsp");
			   }
		      
		     
	       
		   		      
		      if (submit.equals("Cancel Patient's Appointment")) //Doctor's Cancel appointment
		      {
		    	  String[] results = request.getParameterValues("test6");
		    	   long amka = Long.parseLong(request.getParameter("amka"));
			        String condition = "delete patient appointment";
			        for (int i =0; i< results.length; i++)
			        {
			        	String t = results[i];
			        	try {
							Appointment.update(amka, t, condition);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					
							
			        }

				      response.sendRedirect("/Java_dyn_project/jsp_files/doctor.jsp");
			     }
		      

		      
		      if (submit.equals("Insert Appointment/Appointments")) //insert appointment apo patient gia opoiondhpote giatro
		      {
		    	  String[] results = request.getParameterValues("test8");
		    	  
		    	   long amka = Long.parseLong(request.getParameter("amka"));
			       long damka= 0; 
			        for (int i =0; i< results.length; i++)
			        {
			        	String t = results[i];
			        	//System.out.println(t.substring(20));

			        	//System.out.println(t.substring(0,19));
			        	damka= Long.parseLong(t.substring(20));
			      	
					try {
						Appointment.update_special(amka,t.substring(0, 19), damka);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
							
			        }

				      response.sendRedirect("/Java_dyn_project/jsp_files/patient.jsp");
			     }
		      
		      
		       if (submit.equals("Search")) //search for specific department name
		       { 
		    	   String[] results = request.getParameterValues("special");

			      for (int i =0; i<results.length;i++)
			      {
			    	  String dep_name = results[i];
			    	  Patient.setNameDep(dep_name);
			    	  //sql = "select d.name,surname from doctor as d,departments as dep where d.specialty=dep.id and dep.name=?";
			    	  //Patient.search(dep_name,sql);
							
			      }
			      response.sendRedirect("/Java_dyn_project/jsp_files/patient.jsp");
		          	        
		       }
		       

		       if (submit.equals("Search for Appointments"))  //search for specific doctor based on department name
		       { 
		    	   String[] results = request.getParameterValues("doctor");

			      for (int i =0; i<results.length;i++)
			      {
			    	  long amka = Long.parseLong(results[i]);
			    	  Patient.setAmkaDoc(amka);
			    	  //sql = "select d.name,surname from doctor as d,departments as dep where d.specialty=dep.id and dep.name=?";
			    	  //Patient.search(dep_name,sql);
							
			      }
			      response.sendRedirect("/Java_dyn_project/jsp_files/patient.jsp");
		          	        
		       }
		       
		       if (submit.equals("Submit Appointment/Appointments")){ //insert appointment SPECIFIC DOCTOR
			    	  String[] results = request.getParameterValues("test7");
			    	   long amka = Long.parseLong(request.getParameter("amka"));
			    	    String condition = "insert appointment specific doctor";
				        
				        for (int i =0; i< results.length; i++)
				        {
				        	String t = results[i];
				      	
						try {
							Appointment.update(amka, t, condition);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
								
				        }

					      response.sendRedirect("/Java_dyn_project/jsp_files/patient.jsp");
				     }
		      
		       
		       if (submit.equals("Cancel Appointment"))  //Patient's Cancel Appointment
			      {
			    	  String[] results = request.getParameterValues("test5");
			    	   long amka = Long.parseLong(request.getParameter("amka"));
				        String condition = "delete appointment";
				        for (int i =0; i< results.length; i++)
				        {
				        	String t = results[i];
				        	try {
								Appointment.update(amka, t, condition);
							} catch (Exception e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						
								
				        }

					      response.sendRedirect("/Java_dyn_project/jsp_files/patient.jsp");
				     }


		      
		     
		    	  
		}
}
	
	
	
