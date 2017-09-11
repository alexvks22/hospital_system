# hospital_system
This is an offline appointment system that can be accesed by registered doctors, patients and admins. 
This system has been created in order to offer clients the opportunity to explore some major information about a certain hospital.
Having had a database with all the important information about registered doctors and clients, the system offers that you can choose
available dates to make an appointment with a doctor. Of course, it gives the opportunity that the doctor set his/her availability and so
the patient can choose between the available ones.
In order that everything works fine:
1)You have to create a database in PostrgreSQL with the given .csv files,
2)Install Tomcat 8.0 server
3)Modify context.xml file of your Tomcat Server, inserting text like this:

<//Resource auth="Container" driverClassName="org.postgresql.Driver" maxActive="8" 
name="jdbc/LiveDataSource" password="" type="javax.sql.DataSource"
url="jdbc:postgresql://localhost:5432/JavaProject" username="">
<//Resource>

4)Import postgresql.jar in Eclipse or whatever program you may use to execute,
5)In Patient/Doctor/Admin/Appointment java files you must enter your username and password of your Postgres account
6)(Optional in Eclipse) Connect your database via Data source explorer 

This project has been created with two other fellow students, due to our Undergraduate program in University of Piraeus - Department of 
Informatics, on the lesson "Web-based Programming".

