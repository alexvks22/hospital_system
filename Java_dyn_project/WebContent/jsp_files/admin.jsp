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
    document.getElementById("table"+nr).style.display="block";
}

$(function() {
	$("#test_sub").click(function(e){

	    var number_of_checked_checkbox= $("input[name=test]:checked").length;
	    if(number_of_checked_checkbox==0){
	        alert("Select someone before submit");
	        return false;
	    }else{
	    	al
	        $("#tesy").submit();
	    }

	});
	$('#test_sub1').click(function(e) {
		var number_of_checked_checkbox1= $("input[name=test2]:checked").length;
	    if(number_of_checked_checkbox1==0){
	        alert("Select someone before submit");
	        return false;
	    }else{
	        $("#tesy1").submit();
	    }
	});
	$('#test_sub2').click(function(e) {
		var number_of_checked_checkbox2= $("input[name=test3]:checked").length;
	    if(number_of_checked_checkbox2==0){
	        alert("Select someone before submit");
	        return false;
	    }else{
	    	alert(input[name=check2]);
	        $('#tesy2').submit();
	    }
	});
});

//function clicked(nm) {
	//alert(nm);
//}


/*function clicked() 
{
	document.getElementById("insert");
	return "clicked";
	}
	
	function to_call_checked(value){
		checked(value);
	}*/



//pataw submit, kai tote ean to 1o checkbox is checked return 1 (i to opoio tha auksanetai meta apo kathe klisi)
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
    background-color:#18A99C ;
      cursor: pointer;
       background-size: 150% 150%;
      
   
}


</style>

</head>
<body style="background-color: #81F7F3;">
	
	<ul id="menu_bar">
	<li class="menu_bar"> <a href="index.jsp" class="a_menu">Menu</a> </li>
	<li>	
	<a href="check_out_page.jsp" class="a_menu" style="float:right">Log Out</a>  <!--  style='float: right' -->   
	     </li>
	</ul>   
        
        <%@page import = "ask_1.src.lab_ask1.Database_Helper" %>
        
        
	  <% Connection conn = null;
   	ResultSet rst = null;
   	Statement s = null;
   	String user = null;
   	int count =0;
   
   	String username = null;
  	String sessionID = null;
  	
	  	if (session.getAttribute("username") == null){
	  		response.sendRedirect("adminlog.html");
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
        	conn =  Database_Helper.establish_connection();  
        	 s=conn.createStatement();
    		//ResultSet rst=s.executeQuery("select * from admin where username='"+n+"' and password='"+p+"'");
    		rst=s.executeQuery("select * from admin where username='"+username+"'");
    		//HASH AND SALT prokeimenou na ehoume access sta dedomena tou loged in user
    		
    		
    		 while(rst.next()){
            %>
             <h3> Welcome <%= rst.getString("name") %> <%= rst.getString("surname") %> </h3>
             
        <h3> Your Account Information </h3>
        <table>
       <tr> <td> Username: </td> <td> <input type='text' name='username' value='<%=rst.getString("username")%>' readonly> </td> </tr> 
       <tr> <td> Name: </td> <td> <input type='text' name='name' value='<%=rst.getString("name")%>'  readonly> </td> </tr>
       <tr> <td> Surname: </td> <td> <input type='text' name='surname' value='<%=rst.getString("surname")%>'  readonly> </td> </tr>
       
        </table>
        <% } 	
    		 conn.close(); 
        rst.close();
        s.close();
        %>
           
            <%
 
        } catch (NumberFormatException ex) {
            %>
            	<p style = color:black;> <%= ex.toString() %> </p>
            <%
        }
    %>
    
            
        <br> 
        
    <ul style="list-style-type: square">
    	            <li><a href="#" onclick='show(1)'>Insert New Doctor</a></li>
    	           
    	        </ul>
        
        <%! int count = 0; %>
        <%
        try {

        	conn =  Database_Helper.establish_connection(); 
    		s=conn.createStatement();
    		rst=s.executeQuery("select count(*) from pending");
           	
    		 while(rst.next()){
    			count = rst.getInt(1);
    		 }
    		 
    		   if (count == 0 ) {%>
    	        
    	        <!--  if doctor registration pending, the first admin connected will insert them into database
    	        		create a database with pending resistrations! -->
    	           
    	       
				<p> No registrations pending.</p>			
			
    	            	<% } else {%>
    	        
    	        <p> Pending Doctor Registrations : <%= count %> </p>
    	            	<% } %>
    	           
    	           
    	  
        	  <div id="table1" style="display: none"> 
        	  <form action="../insertservlet" method="POST" id="tesy">      
          
            
    	         <table border ="1" style ="background-color:white">
            
             <tr>
        	<th> Doctor AMKA </th>
        	<th> Username </th>
        	<th> Name </th>
        	<th> Surname </th>
        	<th> Specialty </th>
        	<th> Insert </th>
        	</tr>
    	       <%
    	            rst = s.executeQuery("select doctorAMKA, username, password, p.name, surname, dep.name from pending as p,departments as dep where p.specialty = dep.id");
    	            
    	       	while (rst.next()){
    	            %>
    	            
            	<tr>
            
            <td>   <%= rst.getLong("doctorAMKA") %> </td> 
           <td> <%= rst.getString("username") %> </td> 
            <td> <%= rst.getString("name") %> </td> 
            <td> <%= rst.getString("surname") %> </td>
            <td> <%= rst.getString(6)%> </td> <!--  to hrisimopoiw ws getString(int number) dioti sygxeetai to p.name me dep.name -->
            <td><input type="checkbox" name="test" value = "<%= rst.getLong("doctorAMKA") %>"/>&nbsp;</td>
             
           </tr>
           <% }%>
    	           
    	       
    		 
           </table>
           <br>
           <% if (count !=0) { %>
           <input type ="submit" id="test_sub" name ="submit" value ="Insert Doctor" onclick="if(!this.form.test.checked){alert('You must select a doctor before submitting.');return false"/>
         <%} //end of if%>
        	</form>
           </div>
           <br>
           
           <ul style="list-style-type: square">
    	        <li><a href="#" onclick='show(2)'>Insert request of New Patient</a></li>
    	             
    	        </ul>
           
           
    		 <% 
    		 rst = s.executeQuery ("select count(*) from pending_pat");
				while (rst.next()) {
					count = rst.getInt(1);
					}
        
				if (count == 0){
				%>
				
				
				<p> No registrations pending.</p>			
			
				<% } else { %>
				
				<p> Pending Patient Registrations: <%= count %> </p>
				
				

			<% } %>
			
			 
				
			<div id="table2" style="display: none">  
			<form action="../insertservlet" method="POST" id="tesy1">   
 			   
 
  <table border ="1" style ="background-color:white">
            
            <tr>
        	<th> Patient AMKA </th>
        	<th> Username </th>
       		<th> Name </th>
        	<th> Surname </th>
        	<th> Gender </th>
        	<th> Insert </th>
        	</tr>
			
		<% rst = s.executeQuery("Select * from pending_pat");
			
			while (rst.next()) {
				%>
				
				<tr>
				    <td>   <%= rst.getLong("patientAMKA") %> </td> 
           <td> <%= rst.getString("userid") %> </td> 
            <td> <%= rst.getString("name") %> </td> 
            <td> <%= rst.getString("surname") %> </td>
            <td> <%= rst.getString(6)%> 
			</td> <!--  to hrisimopoiw ws getString(int number) dioti sygxeetai to p.name me dep.name -->
            <td>
				<input type="checkbox" name="test2" value = "<%= rst.getLong("patientAMKA") %>"/>&nbsp;</td>
             
           </tr>
           <% } //end of while
			    %>
				
				  </table>
      <br>
      <% if (count!=0){ %>
      <input type ="submit" id="test_sub1" name ="submit" value ="Submit Patient"/>
       <%} //end of if %>
			</form>
			 </div>
            <br>
            
            <ul style="list-style-type: square">
    	            <li><a href="#" onclick='show(3)'>Delete Doctor</a></li>
    	            
    	        </ul>
				
				
				
        	<% rst = s.executeQuery ("select count(*) from doctor");

		while (rst.next()) {
			count = rst.getInt(1);
				} //end of if

		if (count == 0) { 
		%>

	
	<p> No available Doctors in this Hospital. </p>
		<% } else { //end of if, start of else %>
	
	
	<p> Current registered Doctors: <%= count %> </p>

	<% } %>

	  
		<form action="../insertservlet" method="POST" id="tesy2">  
		 <div id="table3" style="display: none">     
 
  			<table border ="1" style ="background-color:white">
            
             <tr>
        	<th> Doctor AMKA </th>
        	<th> Username </th>
       		<th> Name </th>
        	<th> Surname </th>
        	<th> Specialty </th>
        	<th> Delete </th>
        	</tr>
			
		<% rst = s.executeQuery("select doctorAMKA, username, password, d.name, surname, dep.name from doctor as d, departments as dep where dep.id = d.specialty");
			
			while (rst.next()) {
				%>
				
				<tr>
				    <td>   <%= rst.getLong("doctorAMKA") %> </td> 
           <td> <%= rst.getString("username") %> </td> 
            <td> <%= rst.getString("name") %> </td> 
            <td> <%= rst.getString("surname") %> </td>
            <td> <%= rst.getString(6)%> 
			</td> <!--  to hrisimopoiw ws getString(int number) dioti sygxeetai to p.name me dep.name -->
            <td>
				<input type="checkbox" name="test3" value = "<%= rst.getLong("doctorAMKA") %>"/>&nbsp;</td>
             
           </tr>
           <% }
				
    	            conn.close();
    	            rst.close();%>
					
					  </table>
           <br>
           
           <input type ="submit" id="test_sub2" name ="submit" value ="Delete Doctor" onclick="if(!this.form.test3.checked){alert('You must select a doctor before submitting.');return false"/>
		     
			 </div>
           
        	</form>  
        <% } catch (Exception e)
        {	%>
                	<p style=color:white;> <%= e.toString() %> </p>
			<% } %>
        <br>
         
        	
        	
        
          
</body>
</html>