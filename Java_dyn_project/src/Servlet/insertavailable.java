package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import ask_1.src.lab_ask1.Database_Helper;
/**
 * Servlet implementation class insertavailable
 */
@WebServlet("/insertavailable")
public class insertavailable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public insertavailable() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
    private DataSource datasource = null;
    
    public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
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
		
		try {
			//PrintWriter out = response.getWriter();
		
		String am=request.getParameter("amka");
    	int ID = Integer.parseInt(request.getParameter("id"));
		//out.println(am);
		String d=request.getParameter("date");
		//out.println(d);
		String[] ids=request.getParameterValues("time");
		
		Connection conn = Database_Helper.establish_connection();

        PreparedStatement pst = null;
        ResultSet rs = null;
        
		for(int i=0;i<ids.length;i++){
			try {
	        	pst = conn .prepareStatement("insert into appointments (id, t, doctorAMKA) values ((select id from appointments order by id desc limit 1)+1,'" + d+" " +ids[i]+"',"+am+")");
    			pst.executeUpdate();
			}
			catch(Exception e)
	        {
	        	System.out.println("You have selected some values that already exist.");
	        }
			
		}
		
            try {
				conn.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
        	try {
				pst.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        
		}
		catch(Exception e)
		{
			
		}
		response.sendRedirect("/Java_dyn_project/jsp_files/doctor.jsp");
			     
	}

}
