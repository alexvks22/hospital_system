package ask_1.src.lab_ask1;
import java.sql.Connection;
import java.security.MessageDigest;
import javax.xml.bind.DatatypeConverter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.postgresql.util.PSQLException;

import com.sun.xml.internal.bind.v2.schemagen.xmlschema.List;

public class Patient {
	
	public static String department_name;

	public static long doctorAMKA;
	
	
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
	
	public static boolean check(long patientAmka, String useid) {
		boolean status = false;
		
        Connection conn = establish_connection();

        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
           
            pst = conn
                    .prepareStatement("select * from patient where patientamka=? or userid=?");
            pst.setLong(1, patientAmka);
            pst.setString(2, useid);
            
            rs = pst.executeQuery();
            status = rs.next();
            
            conn.close();
        	pst.close();
        	rs.close();
          
        }
        catch(Exception e)
        {
        	System.out.println(e.toString());
        }
		
		
		return status;
	}
	public static boolean check2(long patientAMKA, String useid){
		boolean status = false;
		
        Connection conn = establish_connection();

        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
           
            pst = conn
                    .prepareStatement("select * from pending_pat where patientAMKA=? or userid=?");
            pst.setLong(1, patientAMKA);
            pst.setString(2, useid);
            
            rs = pst.executeQuery();
            status = rs.next();
            
            conn.close();
        	pst.close();
        	rs.close();
          
        }
        catch(Exception e)
        {
        	System.out.println(e.toString());
        }
        
		return status;
	}

	public static boolean register(long patientAMKA, String useid, String usepas, String namepat, String surnamepat, String gender){
		boolean status = false;
		
		
        Connection conn = establish_connection();

        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            pst = conn .prepareStatement("insert into pending_pat (patientAMKA, userid, password, name, surname, gender) values('"+patientAMKA+"','"+useid+"','"+getHash(usepas.getBytes(),"MD5")+"','"+namepat+"','"+surnamepat+"','"+gender+"')");
           
            rs = pst.executeQuery();
            status = rs.next();
          
            conn.close();
        	pst.close();
        	rs.close();
        }
        catch(Exception e)
        {
        	//System.out.println(e.toString());
        }
       

		return status;
	}
	

	public static void setAmkaDoc(Long amka)
	{
		doctorAMKA = amka; 
	}
	
	public static void setNameDep(String dep_name)
	{
		department_name = dep_name;
	}
	
	
	
	
	
    public static boolean validate(String name, String pass) {        
        boolean status = false;
        Connection conn = establish_connection();

        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
           
       	 
            pst = conn
                    .prepareStatement("select * from patient where userid=? and password=?");
           
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