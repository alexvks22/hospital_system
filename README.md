# hospital_system
This is a localy based appointment system that can be accesed by registered doctors, patients and admins. 
This system has been created in order to offer clients the opportunity to explore some major information about a certain hospital.
Having had a database with all the important information about registered doctors and clients, the system offers that you can choose among available dates in order to set an appointment with a doctor. Of course, it gives you the opportunity that the doctor set his/her availability and so the patient can choose between the available ones.

I worked with Eclipse neon.3
In order that everything works fine:
1)You have to create a database in PostrgreSQL with a desirable name,
2)Execute the .sql file
3)Import the given .csv files,
4)Install Tomcat 7.0 server in Eclipse
5)Modify context.xml file of your Tomcat Server, inserting text like this:

<//Resource auth="Container" driverClassName="org.postgresql.Driver" maxActive="8" 
name="jdbc/LiveDataSource" password="" type="javax.sql.DataSource"
url="jdbc:postgresql://localhost:port/name_of_database" username="">
<//Resource>

6)In Database_Helper java file you must enter your username and password of your Postgres account
7)Import postgresql.jar in Eclipse or whatever program you may use to execute,
8)(Optional) Connect your database via Data source explorer 

It's urge that you encrypt your data in your database.
The Data given are fake because of our need to get in contact with plenty of data.

This project has been created with two other fellow students, due to our Undergraduate program in University of Piraeus - Department of 
Informatics, on the lesson "Web-based Programming".

