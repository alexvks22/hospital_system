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

import ask_1.src.lab_ask1.Doctor;

/**
 * Servlet implementation class RegisterDocServlet
 */
@WebServlet("/registerdocservlet")
public class RegisterDocServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterDocServlet() {
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
		  
		  String dA=request.getParameter("doctorAMKA"); 
	       String iddoc=request.getParameter("usernamedoc"); 
	       String passd=request.getParameter("passdoc"); 
	       String named=request.getParameter("namedoc"); 
	       String surnamed=request.getParameter("surnamedoc"); 
	       String special=request.getParameter("specialty");
	       
	       if (!dA.matches(".*[a-z].*")) { 
	    	   int i =Integer.parseInt(special);
	 	      long l = Long.parseLong(dA);   
	 	        
	 	   if(Doctor.check(l, iddoc) || Doctor.check2(l, iddoc))
	       {
	       	
	 		   out.println("<p style=\"color:white; font-family:Verdana\">Doctor AMKA or UserID already exists</p>");
	       		RequestDispatcher rd=request.getRequestDispatcher("registerdoc.html");
	       		rd.include(request,response); 
	       		out.close();
	           out.println("</body>");
	           out.println("</html>");
	         }
	       else
	       {
	       	Doctor.register(l, iddoc, passd, named, surnamed, i);
	       	out.println("<p>Registration finished. Wait 'till administrator accepts you.</p>");

	           response.sendRedirect("index.html");
	           
	           
	           // NA VRW GIA TIME IN ORDER TO REDIRECT STHN INDEX
	           out.println("</body>");
	           out.println("</html>");
	           out.close();
	       }
	       }
	       else {
	    	   out.println("<p style=\"color:white; font-family:Verdana\">Enter a valid AMKA number.</p>");
		     
	       	RequestDispatcher rd=request.getRequestDispatcher("registerdoc.html");
	       	rd.include(request,response); 
	       	out.close();
	           out.println("</body>");
	           out.println("</html>");
	    	   
	    	   
	       }
	       
	}

}
