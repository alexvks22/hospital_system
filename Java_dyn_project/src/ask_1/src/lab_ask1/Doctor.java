package ask_1.src.lab_ask1;
import java.sql.Connection;
import java.security.MessageDigest;
import javax.xml.bind.DatatypeConverter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Doctor  extends Database_Helper {

	
	
	public static boolean check(long doctorAMKA, String useid) {
		boolean status = false;
		
        Connection conn = establish_connection();

        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
           
            pst = conn
                    .prepareStatement("select * from doctor where doctoramka=? or username=?");
            pst.setLong(1, doctorAMKA);
            pst.setString(2, useid);
            
            rs = pst.executeQuery();
            status = rs.next();
          
        }
        catch(Exception e)
        {
        	System.out.println(e.toString());
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
	
	
	public static boolean check2(long doctorAMKA, String useid) {
		boolean status = false;
		
        Connection conn = establish_connection();

        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
           
            pst = conn
                    .prepareStatement("select * from pending where doctoramka=? or username=?");
            pst.setLong(1, doctorAMKA);
            pst.setString(2, useid);
            
            rs = pst.executeQuery();
            status = rs.next();
          
        }
        catch(Exception e)
        {
        	System.out.println(e.toString());
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
	
	public static boolean register(long doctorAMKA, String usedoc, String docpas, String namedoc, String surnamedoc, int special) {
		boolean status = false;
		
        Connection conn = establish_connection();

        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            pst = conn
                    .prepareStatement("insert into pending (doctoramka, username, password, name, surname, specialty) values('"+doctorAMKA+"','"+usedoc+"','"+getHash(docpas.getBytes(),"MD5")+"','"+namedoc+"','"+surnamedoc+"','"+special+"')");
           
            rs = pst.executeQuery();
            status = rs.next();
          
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
	
	
	public static boolean validate(String name, String pass) {        
        boolean status = false;
        Connection conn = establish_connection();

        PreparedStatement pst = null;
        ResultSet rs = null;
        
        
        try {
        	  pst = conn
                      .prepareStatement("select * from doctor where username=? and password=?");
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