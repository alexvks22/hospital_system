package ask_1.src.lab_ask1;

import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.xml.bind.DatatypeConverter;

public class Admin extends Database_Helper{
	
	
	

	public static void insert_and_delete_from_pending(long AMKA,String insert_sql, String delete_sql) {


        Connection conn = establish_connection();
        PreparedStatement pst = null;
        try {
       
        	pst = conn
                     .prepareStatement(insert_sql);
          //  pst = conn
            //        .prepareStatement("insert into doctor (doctorAMKA, username, password, name, surname, specialty) select * from pending");
        	pst.setLong(1, AMKA);
           pst.executeUpdate();
        		
           
            
           pst = conn.prepareStatement(delete_sql);
           pst.setLong(1, AMKA);
           pst.executeUpdate();

        }
        catch(Exception e)
        {
        	System.out.print(e.toString());
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
		

	
	public static void delete(long AMKA, String delete_sql)
	{
		  Connection conn = establish_connection();

	        PreparedStatement pst = null;
	        try {
	        	
	           pst = conn.prepareStatement(delete_sql);
	           pst.setLong(1, AMKA);
	           pst.executeUpdate();

	        }
	        catch(Exception e)
	        {
	        	System.out.print(e.toString());
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
			
		
	

    public static boolean validate(String name, String pass) {        
        boolean status = false;

        Connection conn = establish_connection();

        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
           
        
            pst = conn
                    .prepareStatement("select * from admin where username=? and password=?");
          
            
            pst.setString(1, name);
            pst.setString(2, getHash(pass.getBytes(),"MD5"));

            rs = pst.executeQuery();
            status = rs.next();

        } catch (Exception e) {
            System.out.println(e);
        } finally {
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
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return status;
    }
    
    public static String getHash(byte[] inputBytes, String algorithm){
    	String hashValue="";
    	try{
    		MessageDigest messageDigest = MessageDigest.getInstance(algorithm);
    		messageDigest.update(inputBytes);
    		byte[] digestedBytes = messageDigest.digest();
    		hashValue = DatatypeConverter.printHexBinary(digestedBytes).toLowerCase();
    		
    	}
    	catch(Exception e){}
    	return hashValue;
}   
}