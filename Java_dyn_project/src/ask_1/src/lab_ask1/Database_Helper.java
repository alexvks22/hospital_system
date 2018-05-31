package ask_1.src.lab_ask1;

import java.sql.Connection;
import java.sql.DriverManager;

public class Database_Helper {
	
	public static Connection establish_connection () {
	    Connection conn = null;
        String url = "jdbc:postgresql://localhost:5432/";
        String dbName = "";
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
	

}
