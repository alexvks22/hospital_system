/**
 * 
 */
package ask_1.src.lab_ask1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * @author p15013
 *
 */
public class Appointment  extends Database_Helper {

	public Appointment() {
		// TODO Auto-generated constructor stub
		
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
        finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            
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
        finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            
            	}
        
       
		
	}
	
	/**
	 * 
	 */
	


}
