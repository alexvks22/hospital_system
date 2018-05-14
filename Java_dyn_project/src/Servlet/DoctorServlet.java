package Servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

import javax.naming.InitialContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import ask_1.src.lab_ask1.Admin;
import ask_1.src.lab_ask1.Doctor;
import ask_1.src.lab_ask1.Patient;

/**
 * Servlet implementation class DBServlet
 */
@WebServlet("/doctorservlet")
public class DoctorServlet extends HttpServlet {
 private static final long serialVersionUID = 1L;
 
 //private Doctor doctor1=new Doctor(1);

 private DataSource datasource = null;
 boolean b = false;
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
 public DoctorServlet() {
  super();
  // TODO Auto-generated constructor stub
 }

 /**
  * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
  */

 /**
  * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
  */
 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	 response.setContentType("text/html; charset=UTF-8");
	  response.setCharacterEncoding("UTF-8");
	  request.setCharacterEncoding("UTF-8"); 
	        PrintWriter out = response.getWriter();  
	        out.println("<html>");
	  out.println("<head></head>");
	  out.println("<body style='background-color:#81F7F3;'>");
       String n=request.getParameter("username");  
       String p=request.getParameter("userpass"); 
            

       if(Doctor.validate(n, p)){
       	
       	//out.println("<input type='button' onClick = parent.location='/Java_dyn_project/patientlog.html' value = 'Log out' style='float: right;'>");
           //tha to valw st jsp arxeio ^^
    	   HttpSession session = request.getSession();
       	session.setAttribute("username", n);
       	session.setMaxInactiveInterval(30*60);
       	Cookie username = new Cookie("username", n);
       	username.setMaxAge(30*60);
       	response.addCookie(username);
       	response.sendRedirect("jsp_files/doctor.jsp");
       	
       	
      // 	RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/doctor.jsp");
          // rd.include(request, response); 
           
     	response.setHeader("Cache-Control","no-store"); 
        response.setHeader("Pragma","no-cache"); 
        response.setHeader("Expires", "0");
         
           out.close();
           out.println("</body>");
           out.println("</html>");
       }  
       else{  
           out.print("<p style=\"color:black; font-family:Verdana\">Sorry username or password error</p>");  
           RequestDispatcher rd=request.getRequestDispatcher("doctorlog.html");  
           rd.include(request,response);  
           out.close();
           out.println("</body>");
           out.println("</html>");
       	} 
       
       
      
      //       ResultSet rst=s.executeQuery("select * from doctor where username='"+n+"' and password='"+p+"'");
        
 }  
}
