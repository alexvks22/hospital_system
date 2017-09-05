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
<script>

function show(nr) {
    document.getElementById("table1").style.display="none";
    document.getElementById("table2").style.display="none";
    document.getElementById("table3").style.display="none";
    document.getElementById("table4").style.display="none";
    document.getElementById("table5").style.display="none";
    document.getElementById("table6").style.display="none";
    document.getElementById("table"+nr).style.display="block";
}
$(function() {
	$("#test_sub").click(function(e){

	    var number_of_checked_checkbox= $("input[name=test7]:checked").length;
	    if(number_of_checked_checkbox==0){
	        alert("You have to select an Appointment from the doctor you have selected");
	        return false;
	    }else{
	    	al
	        $("#tesy").submit();
	    }

	});
	
	$('#can').click(function(e) {
		var number_of_checked_checkbox1= $("input[name=test5]:checked").length;
	    if(number_of_checked_checkbox1==0){
	        alert("Please select an appointment to Cancel");
	        return false;
	    }else{
	        $("#cancel").submit();
	    }
	});
	$('#test_sub1').click(function(e) {
		var number_of_checked_checkbox1= $("input[name=test8]:checked").length;
	    if(number_of_checked_checkbox1==0){
	        alert("You have to select an Appointment from the doctor you have selected");
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
color: blue;
}
a: link, a:visited {
color:blue;}
a:hover {
color:black;}

#table1,#table2,#table3,#table4,#table5,#table6
{
display:none;}

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
    background-color:#5992BF ;
      cursor: pointer;
       background-size: 150% 150%;
      
   
}

</style>

</head>
<body style="background-color: #5992BF;">
	
	<ul id="menu_bar">
	<li class="menu_bar"> <a href="../index.html" class="a_menu">Menu</a> </li>
	<li>	
	<a href="check_out_page.jsp" class="a_menu" style="float:right">Log Out</a>  <!--  style='float: right' -->   
	     </li>
	</ul>
	    
	    <%@page import = "ask_1.src.lab_ask1.Patient" %>
	    
	    
        
	    
     	<% 
     	Connection conn = null;
     	ResultSet rst = null;
     	Statement s = null;
     	String user = null;
     	long patientAMKA = 0;
     	int count =0;
     	
     	
     	
	  	if (session.getAttribute("username") == null && session == null){
	  		response.sendRedirect("patientlog.html");
	  	}
	  	else
	  		{user = (String) session.getAttribute("username");}
	  	
	  	
	  	
	   
		%>
		        <%@ page import = "java.sql.*" %>
       <%
        try {
        	conn = Patient.establish_connection();
        	s=conn.createStatement();
    		//ResultSet rst=s.executeQuery("select * from patient where userid='"+n+"' and password='"+p+"'");
           	rst=s.executeQuery("select * from patient where userid='"+session.getAttribute("username")+"'");
           	
    		 while(rst.next()){
    			 patientAMKA =rst.getLong("patientAMKA");
            %>
             
             
             <h3> Welcome <%= rst.getString("name") %> <%= rst.getString("surname") %> </h3>
        		<h3> Your Account Information </h3>
        		<table>
			        <tr> <td> Patient AMKA: </td> <td> <input type='numeric' name='patientamka' value='<%=rst.getLong("patientamka")%>' readonly> </td> </tr>
			       <tr> <td> Username: </td> <td> <input type='text' name='userid' value='<%=session.getAttribute("username")%>' readonly> </td> </tr> 
			       <tr> <td> Name: </td> <td> <input type='text' name='name' value='<%=rst.getString("name")%>' readonly> </td> </tr>
			       <tr> <td> Surname: </td> <td> <input type='text' name='surname' value='<%=rst.getString("surname")%>' readonly> </td> </tr>
			       <tr> <td> Gender: </td> <td> <input type='text' name='gender' value='<%=rst.getString("gender")%>' readonly> </td> </tr>
			     
       			</table>
       					 <% } //end of while	%>
           
            
        <br>
        	 <br>
        <ul style="list-style-type: square">
            <li><a href="#" onclick='show(1)'>Older Appointments</a></li>
          		<% rst = s.executeQuery ("select count(*) from appointments where t < now() and patientAMKA="+patientAMKA+"");
            			
								while (rst.next()) {
									count = rst.getInt(1);
									}
								if (count == 0) { 
									%>
									
								<p> You haven't older appointments. </p>
								<% } else { //end of if start of else%>
								<p>Total number of older appointments: <%= count %> </p>
				<% }  //end of else%>
				
				<div id="table1">  
         		 <%
         			 rst= s.executeQuery(" SELECT t, a.doctorAMKA, d.name, d.surname, dep.name FROM patient as p ,doctor as d, appointments as a, departments as dep where (p.patientAMKA = a.patientAMKA AND p.patientAMKA='" + patientAMKA + "'AND a.doctorAMKA = d.doctorAMKA AND d.specialty = dep.ID and t < now()) GROUP BY t, a.doctorAMKA, d.name, d.surname, dep.name ORDER BY t desc");
          			%>
      					<table border ="1" style ="background-color:white">
            
				            <tr>
				        	<th> Date </th>
				       		<th> Doctor AMKA </th>
				        	<th> Doctor Name </th>
				        	<th> Doctor Surname  </th>
				        	<th> Department Name </th>
				        	</tr>
				    <%
				    	while(rst.next()) {
            		%>
		            	<tr>
		            	
		           			<td> <%= rst.getString("t") %> </td> 
		            		<td>   <%= rst.getLong("doctorAMKA") %> </td> 
		          			<td> <%= rst.getString("name") %> </td> 
		            		<td> <%= rst.getString("surname") %> </td> 
		            		<td> <%= rst.getString(5) %> </td>
		            
		           		</tr>
            
           		 						<%}	//end of while%>
            			</table> 
            		</div>
            	
            	
           		 <br />
           		 
            <li><a href="#" onclick='show(5)'>My Medical Folder </a></li>
          		<% rst = s.executeQuery ("select count(*) from medical_folder where patient="+patientAMKA+"");
            			
								while (rst.next()) {
									count = rst.getInt(1);
									}
								if (count == 0) { 
									%>
									
								<p> You haven't medical folder. </p>
								<% } %>
				
				<div id="table5">  
         		 <%
         			 rst= s.executeQuery(" select cure, d.name from drugs as d, medical_folder as m where m.drug_id = d.id and patient = "+patientAMKA+"");
          			%>
      					<table border ="1" style ="background-color:white">
            
				            <tr>
				        	<th> Cure </th>
				        	<th> Drug or Drugs </th>
				        	</tr>
				    <%
				    	while(rst.next()) {
            		%>
		            	<tr>
		            	
		           			<td> <%= rst.getString("cure") %> </td> 
		            		<td> <%= rst.getString(2) %> </td>
		            
		           		</tr>
            
           		 						<%}	//end of while%>
            			</table> 
            		</div>
            	
            	
           		 <br />
            
            <li><a href="#" onclick='show(2)' >Show future appointments</a> </li>
        		   
        		   <% rst = s.executeQuery ("select count(*) from appointments where t >= now() and patientAMKA="+patientAMKA+"");
            			
								while (rst.next()) {
									count = rst.getInt(1);
									}
								if (count == 0) { 
									%>
								<p> You have no appointments for the next days. </p>
								<% } else { //end of if start of else%>
								<p>Appointments for the next days: <%= count %> </p>
				<% }  //end of else%>
				
					 <div id="table2"> 
						<%	rst = s.executeQuery("Select t, a.doctorAMKA, d.name, d.surname, dep.name from appointments as a, doctor as d, departments as dep, patient as p where a.doctorAMKA = d.doctorAMKA and a.patientAMKA = p.patientAMKA and dep.id = d.specialty and t >= now() and a.patientAMKA="+patientAMKA+" order by t");
								 %>
            					<table border ="1" style ="background-color:white">
        	
					        	<tr>
					        	<th> Date </th>
					       		<th> Doctor AMKA </th>
					        	<th> Doctor Name </th>
					        	<th> Doctor Surname  </th>
					        	<th> Department Name </th>
					        	</tr>
        				
            				
            				<%
           					 while(rst.next()) {
            					%>		
            			 <tr>
            	
						           <td> <%= rst.getString(1) %> </td> 
						            <td>   <%= rst.getLong("doctorAMKA") %> </td> 
						           <td> <%= rst.getString("name") %> </td> 
						            <td> <%= rst.getString("surname") %> </td> 
						            <td> <%= rst.getString(5) %> </td>
            
          						
           				 					<%} //end of while%>
            
            				 		</tr>
            				</table> 
            				 
            </div>   
            	
            <br>
            
            <li> <a href="#" onclick='show(6)'> Choose date of appointment with any doctor </a></li>
					 <% rst = s.executeQuery ("select count(*) from appointments where t >= now() and patientAMKA is null and doctorAMKA is not null");
            			
								while (rst.next()) {
									count = rst.getInt(1);
									}
								if (count == 0) { 
									%>
								<p> There are no available appointments for the next days. </p>
								<% } else { //end of if start of else%>
								<p>Total number of available appointments: <%= count %> </p>
					<% }  //end of else%>
					
					<div id="table6">
					<br>
					<form action="../insertservlet" method="POST" id="tesy1">
					<table border ="1" style ="background-color:white">
					<tr>
					<th> Date </th>
					<th> Doctor AMKA </th>
					<th> Doctor Name </th>
					<th> Doctor Surname </th>
					<th> Specialty </th>
					
					<% rst = s.executeQuery("Select t, a.doctorAMKA,d.name,d.surname, dep.name from appointments as a,doctor as d, departments as dep where dep.id = d.specialty and d.doctorAMKA = a.doctorAMKA and t >= now() and a.patientAMKA is null  and a.doctorAMKA is not null order by t");
        	
			while (rst.next()) {
				%>
			
			<tr>
		        <td> <%= rst.getString("t") %> </td> 
				<td>   <%= rst.getLong("doctorAMKA") %> </td> 
	           	<td> <%= rst.getString("name") %> </td>
	           	<td> <%= rst.getString("surname") %> </td> 
	            <td> <%= rst.getString(5)%> </td> <!--  to hrisimopoiw ws getString(int number) dioti sygxeetai to p.name me dep.name -->
	            <td><input type="checkbox" name="test8" value = "<%= rst.getString("t")+" " + rst.getLong("doctorAMKA") %>"/>&nbsp;</td>
	            
            </tr>
           <% } //end of while
				rst = s.executeQuery("Select patientAMKA from patient where userid='"+session.getAttribute("username")+"'");
				
			
			while (rst.next()) { 
				patientAMKA = rst.getLong("patientAMKA");
			%>
				
				<input type="hidden" name="amka" value="<%= rst.getLong("patientAMKA") %>" />
			
							<% } //end of while	%>
				 
								</table>
           <br>
           
          	 <input type ="submit"  id="test_sub1" name ="submit" value="Insert Appointment/Appointments" />
            
            
					</tr>
					
					</table>
					
					</form>
					
					
					</div>

            <br>
          
		  
          
	 			<li> <a href="#" onclick='show(3)'>Choose date of appointment with specific doctor</a></li>
          			 <div id="table3">
          			 <br>
          			 <form action="../insertservlet" method="POST">
          			 <table>
          			 	<tr>
          			 	<th> Category: </th>
          			 	<td>
          			 		<select id="special" name="special">
          			 		<option value="0"> Select Category </option>
          			 		
          			 		<% 
          			 		
          			 		rst=s.executeQuery("select * from departments");
                            
                            
                            while(rst.next()) {
          			 		%>
          			 		<option name="check" value="<%=rst.getString("name")%>"><%= rst.getString("name")%></option>
			              			<% 
			              					} //end of while%>
			              			
			              			  
          			 		 </select>
          			 		  
          			 	</td>
          			 	</tr>
          			 		  
          			 	<input type="submit" name="submit" value="Search" style="float:right;">
          			 		 
          			 	</form>
          			 	</table>
          			 	
          			 	<table>
          			 	<form action="../insertservlet" method="POST"><tr>
          			 	<th> Doctor: </th>
          			 	<td>
          			 		<select id="doctor" name="doctor">
          			 		<option value="0"> Select Doctor </option>
						        
          			 	<% 
          			 	rst = s.executeQuery("select doctorAMKA,d.name,surname from doctor as d,departments as dep where d.specialty=dep.id and dep.name='"+Patient.department_name+"'");
                  		
          			 	while(rst.next())
          			 	{ 
          			 	 %>
          			 	 <option name="check2" value="<%=rst.getLong("doctorAMKA")%>"><%= rst.getString(2)%>  <%= rst.getString("surname") %></option>
			      			
           <% } //end of while %>
           </select>
           
           </td>
          			 	</tr>
          			 	<input type="submit" name="submit" value="Search for Appointments" style="float:right;">
          			 	
          			 	
          			 	 </form>
          			 	 
          			 	 
          			 	   </table>
          			 	   
          			 	   
				
          			 	   
          			 	   <table border ="1" style ="background-color:white">
						           <form action="../insertservlet" method="post" id="tesy"> 
						            
						             
						             <tr>
						        	<th> Date </th>
						        	</tr>
        	
				
        	<% rst = s.executeQuery("Select t from appointments as a,doctor as d where d.doctorAMKA = a.doctorAMKA and t > now() and a.patientAMKA is null and a.doctorAMKA="+Patient.doctorAMKA+" order by t");
        	
        	
			while (rst.next()) {
				%>
			
			<tr>
		        <td> <%= rst.getString("t") %> </td> 
	           	<td><input type="checkbox" name="test7" value = "<%= rst.getString("t") %>"/>&nbsp;</td>
	            
            </tr>
            
           <% } //end of while %>	
           
            <% rst = s.executeQuery("Select patientAMKA from patient where userid='"+session.getAttribute("username")+"'");
            									
            	while (rst.next()) { 
            		patientAMKA = rst.getLong("patientAMKA");
            			%>
            	<input type="hidden" name="amka" value="<%= rst.getLong("patientAMKA") %>" />
            									
            													<% }//end of while %>
           	
           	<input type="submit" name="submit" id="test_sub" value="Submit Appointment/Appointments" style="float:right" >
          			 	
           </form>
           </table> 
          			 	</div>
          			 	
          			 	
				<br>
    					
           
            <br/>
            
           <li> <a href="#" onclick='show(4)'>Cancel appointment with doctor</a></li>
           		
           		<% rst = s.executeQuery("select count(*) from appointments where patientAMKA ="+patientAMKA+" and t - now() >= interval '3 days'");
			              		while (rst.next())
			              		{	count = rst.getInt(1);
			              			%>
			              			
			              			<%} if (count ==0) { //end of while, start of if %>
			              			
					           <p> You have no appointments for the next days. </p> 
              				
              				
              				<% } else { //end of if start of else	 %>
              				<p> You can cancel <%=count %> appointments based on the restriction that you must submit it 3 days before.</p>
              				<%} //end of else %>
					
					
           				<div id="table4" >
           					<form action="../insertservlet" method="POST" id="cancel">
              				
              				<% rst = s.executeQuery("Select t, a.doctorAMKA, d.name, d.surname, dep.name from appointments as a, doctor as d, departments as dep, patient as p where a.patientAMKA="+patientAMKA+" and p.patientAMKA = a.patientAMKA and dep.id = d.specialty and a.doctorAMKA = d.doctorAMKA and t - now() >= interval '3 days' order by t");
						
							%>
           
							 <table border ="1" style ="background-color:white">
            
					             <tr>
						        	<th> Date </th>
						        	<th> Doctor AMKA </th>
						        	<th> Doctor Name </th>
						        	<th> Doctor Surname </th>
						        	<th> Specialty </th>
								</tr>
							<% while (rst.next()) {
							%>
				
								<tr>
						           <td> <%= rst.getString("t") %> </td> 
						           <td> <%= rst.getLong("doctorAMKA") %> </td>
						           <td> <%= rst.getString(3) %> </td> 
						           <td> <%= rst.getString(4) %> </td>
						           <td> <%= rst.getString(5) %> </td> 
		            			<td>
		            				<input type="checkbox" name="test5" value = "<%=rst.getString("t") %>"/>&nbsp;
		            					</td>
            
           						</tr>
            									<%	} //end of while	%>
            <% rst = s.executeQuery("Select patientAMKA from patient where userid='"+session.getAttribute("username")+"'");
            									
            	while (rst.next()) { 
            		patientAMKA = rst.getLong("patientAMKA");
            			%>
            	<input type="hidden" name="amka" value="<%= rst.getLong("patientAMKA") %>" />
            									
            													<% }//end of while %>
          					</table>
          				 <br>
           <% if (count!=0){%>
           				<input type ="submit"  id="can" name ="submit" value="Cancel Appointment" />
        	<%} %>
            			</form> 
           				
            		</div>
            <br />
           		

            
            <% 
        	} catch(Exception ex) //end of try and start of catch
        	{
        	%>
        	
        	<p style=color:red;> <%= ex.toString() %> </p>
        	
	      	 <%  } finally { //end of catch and start of finally
	       		s.close();
	   			rst.close();
	       		conn.close();
	       		%>

    	   
    	   
       			<%} //end of finally%>
         
    </ul>   
           
      
          
</body>
</html>