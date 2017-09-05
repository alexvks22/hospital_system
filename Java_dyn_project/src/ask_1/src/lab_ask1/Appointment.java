/**
 * 
 */
package ask_1.src.lab_ask1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * @author p15013
 *
 */
public class Appointment {

	public Appointment() {
		// TODO Auto-generated constructor stub
		
	}
	
	public static Connection establish_connection () {
	    Connection conn = null;
        String url = "jdbc:postgresql://localhost:5432/";
        String dbName = "JavaProject";
        String driver = "org.postgresql.Driver";
        String userName = "";
        String password = "";
        
        try {Class.forName(driver).newInstance();
        conn = DriverManager
                .getConnection(url + dbName, userName, password);
        }
        catch(Exception e)
        {
        	System.out.println(e.toString());
        }
        return conn;
	}
	

	public static void update_special(long patientAMKA, String t, long doctorAMKA){
		Connection conn = establish_connection();

        PreparedStatement pst = null;
        
        try
        {
        	 pst = conn
                     .prepareStatement("UPDATE appointments SET patientAMKA ="+ patientAMKA+" where t ='"+t+"' and doctorAMKA="+doctorAMKA+"");

             pst.executeUpdate();
             conn.close();
         	pst.close();
        }
        catch(Exception e)
        {
        	System.out.println(e);
        }
		
	}
	public static void update(long amka, String t, String condition)
	{
		Connection conn = establish_connection();

        PreparedStatement pst = null;
        
        try {
        	if (condition == "insert appointment specific doctor")
        	{
            pst = conn
                    .prepareStatement("UPDATE appointments SET patientAMKA ="+ amka+" where t ='"+t+"' and doctorAMKA="+Patient.doctorAMKA+"");

            pst.executeUpdate();
            conn.close();
        	pst.close();
            }
        	
        	
        	
        	if (condition == "delete appointment")
        	{
        		pst = conn.prepareStatement("UPDATE appointments set patientAMKA = null where patientAMKA = "+amka+"and t ='"+t+"'");
        		pst.executeUpdate();
        		conn.close();
            	pst.close();
        	}
            if (condition == "delete patient appointment")
            {
            	pst = conn.prepareStatement("delete from appointments where t='"+t+"' and doctorAMKA="+amka+"");
            	pst.executeUpdate();
            	conn.close();
            	pst.close();
            }
          
        }
        catch(Exception e)
        {
        	//System.out.println(e.toString());
        }
       
		
	}
	
	/**
	 * 
	 */
	


}
