package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import ask_1.src.lab_ask1.Patient;

/**
 * Servlet implementation class RegisterPatServlet
 */
@WebServlet("/registerpatservlet")
public class RegisterPatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterPatServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		  response.setCharacterEncoding("UTF-8");
		  request.setCharacterEncoding("UTF-8"); 
		        PrintWriter out = response.getWriter();  
		        out.println("<html>");
		  out.println("<head></head>");
		  out.println("<body style='background-color:#81F7F3;'>");
		  
		  String pA=request.getParameter("patientAMKA"); 
	        String idpati=request.getParameter("useridpat"); 
	        String passpat=request.getParameter("userpaspat"); 
	        String namepat=request.getParameter("namepat"); 
	        String surnamepat=request.getParameter("surnamepat"); 
	        String gender=request.getParameter("gender"); 
	        //long l = 0;
	        //try{
	        
	        
	        if (!pA.matches(".*[a-z].*")) { 
	        	

		        long l = Long.parseLong(pA);
	        
	        if(Patient.check(l, idpati) || Patient.check2(l, idpati))
	        {
	        	
	        	out.println("<p style=\"color:white; font-family:Verdana\">Patient AMKA or UserID already exists</p>");
	        	RequestDispatcher rd=request.getRequestDispatcher("registerpat.html");
	        	rd.include(request,response); 
	        	out.close();
	            out.println("</body>");
	            out.println("</html>");
	          }
	        else
	        {
	        	Patient.register(l, idpati, passpat, namepat, surnamepat, gender);
	        	out.println("<p>Registration finished. Wait 'till administrator accepts you.</p>");
	        	response.sendRedirect("index.html");
	        	out.close();
	            out.println("</body>");
	            out.println("</html>");
	        }
	
	        
	        
	        }
	        else {
	        	out.println("<p style=\"color:white; font-family:Verdana\">Enter a valid AMKA number.</p>");
	        	RequestDispatcher rd=request.getRequestDispatcher("registerpat.html");
	        	rd.include(request,response); 
	        	out.close();
	            out.println("</body>");
	            out.println("</html>");
	        	
	        }
	        
	}

}
