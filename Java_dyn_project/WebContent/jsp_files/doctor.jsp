<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Successful Login!</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<script>function show(nr) {
    document.getElementById("table1").style.display="none";
    document.getElementById("table2").style.display="none";
    document.getElementById("table3").style.display="none";
    document.getElementById("table4").style.display="none";
    document.getElementById("table"+nr).style.display="block";
}

$(function() {
    $( "#thedate" ).datepicker({ 
    	minDate: 0, 
    	altField: '#thedate',
    	altFormat: 'yy-mm-dd'
    });
    $('#thedate').on('change',function(){
        if( $(this).val()!=""){
        $("#table5").show()
        }
    });
    $("#fm_submit").click(function(e){

        var number_of_checked_checkbox= $("input[name=time]:checked").length;
        if(number_of_checked_checkbox==0){
            alert("You have to check at least one checkbox before you submit");
            return false;
        }else{
            $("#tesy").submit();
        }

    });
    $("#fm_submit1").click(function(e){

        var number_of_checked_checkbox= $("input[name=test6]:checked").length;
        if(number_of_checked_checkbox==0){
            alert("You have to check at least one checkbox before you submit");
            return false;
        }else{
            $("#tesy1").submit();
        }

    });
    
  });

  
</script>

<style>

body 
{
font-family:Verdana;
}

a {
color: #088A85;
}
a: link, a:visited {
color:#088A85;}
a:hover {
color:black;}

#table1, #table2, #table3, #table4 {
    display: none;
}

#menu_bar {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: white;
    
    border:2px solid;
    border-radius: 15px 50px 30px 5px;
}

.menu_bar {
    float: left;
    
    
}

.a_menu {
    display: block;
    color: black;
    text-align: center;
    float:left;
    padding: 14px 16px;
    text-decoration: none;
     background-size: 100% 100%;
     transition: all .5s ease;
    
}

/* Change the link color to #111 (black) on hover */
.a_menu:hover {
    background-color:#18A99C;
      cursor: pointer;
       background-size: 150% 150%;
      
   
}



</style>

</head>
<body style="background-color:  #81F7F3;">
	    
	<ul id="menu_bar">
	<li class="menu_bar"> <a href="index.jsp" class="a_menu">Menu</a> </li>
	<li>	
	<a href="check_out_page.jsp" class="a_menu" style="float:right">Log Out</a>  <!--  style='float: right' -->   
	     </li>
	</ul>
	<%@page import = "ask_1.src.lab_ask1.Database_Helper" %>
	
	
     	<%
     	Connection conn = null;
     	ResultSet rst = null;
     	Statement s = null;
     	String user = null;
     	long doctorAMKA = 0;
     	int count =0;
     	int id =0;
     	
     	String username = null;
	  	String sessionID = null;
	  	
	  	if (session.getAttribute("username") == null){
	  		response.sendRedirect("doctorlog.html");
	  	}
	  	else user = (String) session.getAttribute("username");
	  	
	  	
	  	Cookie[] cookies = request.getCookies();
	  	if (cookies != null){
	  		for (Cookie cookie:cookies){
	  			if(cookie.getName().equals("username")) username = cookie.getValue();
	  			//if(cookie.getName().equals("userpass")) password = cookie.getValue();
	  			if(cookie.getName().equals("JSESSIONID"))
	  				sessionID = cookie.getValue();
	  		}
	  	}
	  
	   
		%>
		
        <%@ page import = "java.sql.*" %>
        
       <%
        try {
        	conn = Database_Helper.establish_connection();
        	s=conn.createStatement();
    		//ResultSet rst=s.executeQuery("select d.name,surname,doctorAMKA, username, password, specialty, dep.name from doctor as d, departments as dep where username='"+n+"' and password='"+p+"' and d.specialty = dep.id");
           	rst=s.executeQuery("select d.name,surname,doctorAMKA, username, password, dep.name from doctor as d, departments as dep where username='"+username+"'and d.specialty = dep.id");
           	
    		 while(rst.next()){
    			 doctorAMKA = rst.getLong("doctorAMKA");
            %>
             <h3> Welcome <%= rst.getString("name") %> <%= rst.getString("surname") %> </h3>
        <h3> Your Account Information </h3>
        <table>
        <tr> <td> Doctor AMKA: </td> <td> <input type='text' name='doctoramka' value='<%=rst.getString("doctoramka")%>' readonly> </td> </tr>
       <tr> <td> Username: </td> <td> <input type='text' name='username' value='<%=session.getAttribute("username")%>' readonly> </td> </tr> 
       <tr> <td> Name: </td> <td> <input type='text' name='name' value='<%=rst.getString("name")%>'  readonly> </td> </tr>
       <tr> <td> Surname: </td> <td> <input type='text' name='surname' value='<%=rst.getString("surname")%>'  readonly> </td> </tr>
       <tr> <td> Specialty: </td> <td> <input type='text' name='specialty' value='<%=rst.getString(6)%>'  readonly> </td> </tr>
       
        </table>
        <% } //end of while 	
        %>
           
            
        <br>
        <ul style="list-style-type: square">
            <li><a href="#" onclick='show(1);'">Appointments</a></li>
           <% rst = s.executeQuery ("select count(*) from appointments where doctorAMKA="+doctorAMKA+" and t < now() and patientAMKA IS NOT NULL");
            			
								while (rst.next()) {
									count = rst.getInt(1);
									}
								if (count == 0) { 
									%>
									
								<p> You have no appointments at all. </p>
								<% } else { //end of if start of else%>
								<p>Total number of older appointments: <%= count %> </p>
				<% }  //end of else%>
           <div id="table1"> 
           
           <% rst= s.executeQuery("select t, p.patientAMKA, p.name, p.surname, diagnosis from appointments as a, patient as p, doctor as D where (a.doctorAMKA = d.doctorAMKA AND d.username = '"+ username + "'AND p.patientAMKA = a.patientAMKA and t < now()) order by t DESC");
            %>
             <table border ="1" style ="background-color:white">
            
            <tr>
        	<th> Date </th>
       		<th> Patient AMKA </th>
        	<th> Patient Name </th>
        	<th> Patient Surname  </th>
        	<th> Diagnosis </th>
        	</tr>
        	
        	
        	<%
            while(rst.next()) {
            	%>
            	
            	<tr>
            	
           <td> <%= rst.getString("t") %> </td> 
            <td>   <%= rst.getLong("patientAMKA") %> </td> 
           	<td> <%= rst.getString("name") %> </td> 
            <td> <%= rst.getString("surname") %> </td> 
            <% if ( rst.getString("diagnosis") == null ) {
            %>
            <td> </td>
            <% } else { %>
            <td> <%= rst.getString("diagnosis") %> </td>
            <% } //end of else %>
           
            
           
           
            <% 			} //end of while%>
            </tr>
            </table>   
            </div>
        	
            <br />
            
            
           <li> <a href="#" onclick='show(2);'>Scheduled appointments for the next days</a></li>
           
           <% rst = s.executeQuery ("select count(*) from appointments where t >= now() and patientAMKA is not null and doctorAMKA="+doctorAMKA+"");
            			
								while (rst.next()) {
									count = rst.getInt(1);
									}
								if (count == 0) { 
									%>
								<p> You have no appointments. </p>
								<% } else { //end of if start of else%>
								<p>Appointments for the next days: <%= count %> </p>
				<% }  //end of else%>
           
            <div id="table2">  
            
            <%	rst = s.
            		executeQuery("SELECT t, a.patientAMKA, name, surname FROM patient as p, appointments as a where (p.patientAMKA = a.patientAMKA and doctorAMKA=" + doctorAMKA + "and t >= now()) GROUP BY t,a.patientAMKA, doctorAMKA, name, surname ORDER BY t");
  			%>
            					<table border ="1" style ="background-color:white">
        	
					        	<tr>
					        	<th> Date </th>
					       		<th> Patient AMKA </th>
					        	<th> Patient Name </th>
					        	<th> Patient Surname  </th>
					        	</tr>
        				
            				
            				<%
           					 while(rst.next()) {
            					%>		
            			 
            	<tr>
						           <td> <%= rst.getString(1) %> </td> 
						            <td>   <%= rst.getLong("patientAMKA") %> </td> 
						           <td> <%= rst.getString("name") %> </td> 
						            <td> <%= rst.getString("surname") %> </td>
            
          						
           				 					<%} //end of while%>
            
            				 		</tr>
            				</table> 
            				
            </div>
            
            <br />
           <li> <a href="#" onclick='show(3);'>Set Availability</a></li>
           
           
          
				
           <div id="table3">
           
           
            <form action="../insertavailable" method="POST" id="tesy"><table><p>Date: <input type="text" id="thedate" name="date"></p></table>
           </div>
            <div id="table5" style="display:none;">
            <p>Check your available time</p>
            <input type="checkbox" name="time" id="" class="timeselect" value="12:00">12:00</>
            <input type="checkbox" name="time" id="" class="timeselect" value="12:30">12:30</>
            <input type="checkbox" name="time" id="" class="timeselect" value="13:00">13:00</>
            <input type="checkbox" name="time" id="" class="timeselect" value="13:30">13:30</>
            <input type="checkbox" name="time" id="" class="timeselect" value="14:00">14:00</>
            <input type="checkbox" name="time" id="" class="timeselect" value="14:30">14:30</>
            <input type="checkbox" name="time" id="" class="timeselect" value="15:00">15:00</>
            <input type="checkbox" name="time" id="" class="timeselect" value="15:30">15:30</>
            <input type="checkbox" name="time" id="" class="timeselect" value="16:00">16:00</>
            <input type="checkbox" name="time" id="" class="timeselect" value="16:30">16:30</>
            <input type="checkbox" name="time" id="" class="timeselect" value="17:00">17:00</>
            <input type="checkbox" name="time" id="" class="timeselect" value="17:30">17:30</>
            <input type="checkbox" name="time" id="" class="timeselect" value="18:00">18:00</>
           	<input type="button" value="Submit" id="fm_submit" />
           	
           	 <% rst = s.executeQuery("Select doctorAMKA from doctor where username='"+session.getAttribute("username")+"'");
            									
            	while (rst.next()) { 
            		doctorAMKA = rst.getLong("doctorAMKA");
            			%>
            	<input type="hidden" name="amka" value="<%= rst.getLong("doctorAMKA") %>" />
            		
			            								
            													<% }//end of while %>
            													
            													
           	 <% rst = s.executeQuery("Select id from appointments order by t desc limit 1");
            									
            	while (rst.next()) { 
            		id = rst.getInt("id");
            			%>
            	<input type="hidden" name="id" value="<%= rst.getInt("id") %>" />
            		
			            								
            													<% }//end of while %>
           	
          	 
           	</form>
           
           
             </div>
            
            
            
            <br />
           <li> <a href="#" onclick='show(4);' >Cancel appointment</a> </li>
           
            <% 
            rst = s.executeQuery ("select count(*) from appointments where t - now() >= interval '3 days' and patientAMKA is not null and doctorAMKA="+doctorAMKA+"");
            			
								while (rst.next()) {
									count = rst.getInt(1);
									}
								if (count == 0) { 
									%>
								<p> You have no appointments set for the next days. </p>
								<% } else { //end of if start of else%>
								<p> You can cancel <%=count %> appointments based on the restriction that you must submit it 3 days before.</p>
              				
				<% }  //end of else%>
				
				
           
            <div id="table4">
            
           <form action="../insertservlet" method="POST" id="tesy1">
              				
              				<% rst = s.executeQuery("Select t, a.patientAMKA,name,surname from appointments as a, patient as p where doctorAMKA="+doctorAMKA+" and p.patientAMKA = a.patientAMKA and t - now() >= interval '3 days' order by t");
						
							%>
           
							 <table border ="1" style ="background-color:white">
            
					             <tr>
						        	<th> Date </th>
						        	<th> Patient AMKA </th>
						        	<th> Patient Name </th>
						        	<th> Patient Surname </th>
								</tr>
							<% while (rst.next()) {
							%>
				
								<tr>
						           <td> <%= rst.getString("t") %> </td> 
						           <td> <%= rst.getLong("patientAMKA") %> </td>
						           <td> <%= rst.getString("name") %> </td> 
						           <td> <%= rst.getString("surname") %> </td>
		            			<td>
		            				<input type="checkbox" name="test6" value = "<%=rst.getString("t") %>"/>&nbsp;
		            					</td>
            
           						</tr>
            									<%	} //end of while	%>
			            
			            	<input type="hidden" name="amka" value="<%= doctorAMKA %>" />
			            									
			            													
          					</table>
          				 <br>
          <% if (count!= 0) { %> 
           				<input type ="submit" id="fm_submit1" name ="submit" value="Cancel Patient's Appointment" />
        	<% } //end of if %>
        	
            			</form> 
            
            
            
            
            
              </div>   
            
            
        </ul>
            
             
            	
               
           <%
 
        } catch (NumberFormatException ex) { //end of try and start of catch
            %>
            	<p style=color:white;> <%= ex.toString() %> </p>
            <%
        } finally { //end of catch , start of finally
        	s.close();
        	rst.close();
        	conn.close(); %>
        	
        	<%} //end of finally %>
    
</body>
</html>