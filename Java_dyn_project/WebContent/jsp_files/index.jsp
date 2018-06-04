<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<title>Menu</title>
<style>

body
{

font-family:Verdana;
background-image:url(new.jpg);
background-repeat:no-repeat;
background-size: cover;
background-attachment: fixed;

}

.content
{
margin:0 auto;
width:30%;
text-align:center;
}

.center
{
text-align:center;}


.button {
  display: inline-block;
  padding: 15px 25px;
  font-family:Verdana;
  font-size: 24px;
  cursor: pointer;
  text-align: center;
  text-decoration: none;
  outline: none;
  color: #fff;
  background-color:  #088A85;
  border: none;
  border-radius: 15px;
  box-shadow: 0 9px #999;
}

.button:hover {background-color: #18A99C}

.button:active {
  background-color: #18A99C;
  box-shadow: 0 5px #666;
  transform: translateY(4px);
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
</style>
</head>

<body>
<% 
	String user = null;
	String username = null;
	String sessionID = null;
  	String type = null;
  	
  	if (session.getAttribute("username") != null){
  		user = (String) session.getAttribute("username");
  	}
  	
  	if (session.getAttribute("type_of_user") != null){
  		type = (String) session.getAttribute("type_of_user");
  	}
  	
  	Cookie[] cookies = request.getCookies();
  	if (cookies != null){
  		for (Cookie cookie:cookies){
  			if(cookie.getName().equals("username")) username = cookie.getValue();
  			//if(cookie.getName().equals("userpass")) password = cookie.getValue();
  			if(cookie.getName().equals("JSESSIONID"))
  				sessionID = cookie.getValue();
  		}
  	} %>
<% if (session.getAttribute("username") != null){ %><a href="check_out_page.jsp" class="a_menu" style="float:right">Log Out</a> 
<% if (type == "admin") {%><a href="admin.jsp" class="a_menu" style="float:left"> <%= user.toString() %> </a> <%} %>	
<% if (type == "patient") {%><a href="patient.jsp" class="a_menu" style="float:left"> <%= user.toString() %> </a><%} %>
<% if (type == "doctor") {%><a href="doctor.jsp" class="a_menu" style="float:left"> <%= user.toString() %> </a> <%} %>	
<%} %>

  	<h1 class="center">Welcome to "Texnognosia" Clinic!</h1>
<br>

<h3 class="center">Choose above:</h3>
 <div class="content">
<br><br>
<!-- <img src="https://4.bp.blogspot.com/-7P1cvnN0bvc/V3DHrv3ZwOI/AAAAAAAAGQk/qlEZ5o6GKDcCgryiVA37ext9iU1YOhcOgCLcB/s1600/Doctor%2Bappointment%2Bscript.png"/>
 -->
 <br /><br />
 <input type=button onClick="parent.location='/Java_dyn_project/adminlog.html'" value='Admin Login' class="button">
 <br>
 <br>
 <input type=button onClick="parent.location='/Java_dyn_project/patientlog.html'" value='Patient Login' class="button">
 <br>
 <br>
 <input type=button onClick="parent.location='/Java_dyn_project/doctorlog.html'" value='Doctor Login' class="button">
 <br />
 <br>
 <input type=button onClick="parent.location='/Java_dyn_project/register_type.html'" value='Register' class="button">
 <br>
 <br>
 
 </div>
</body>
</html>