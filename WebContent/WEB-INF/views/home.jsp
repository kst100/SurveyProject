<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="resources"%>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link href='<resources:url value="/resources/css/style.css"/>' rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>    
	<title>Home</title>
</head>
<body>
	<!-- Header -->
	<%@ include file="./layout/header.jsp" %>
	
	<!-- Main Container -->
	<div class="container">
		<!-- Menu -->
		<%@ include file="./layout/menu.jsp" %>
		
		<!-- Page code -->
		<div>
			<div>
				<p>	
					I didn't write down the actual time spend on each part as I decided to include this project summary after I finished the backend, so the times are only approximate, but not too far away from the real values.<br><br>
					
					<strong>Total time spend on back end: ~ 50 hours</strong> (working around 2 hours per day + 2 full weekends)<br>
					This project started with "Hello Word" tutorial for Spring MVC and then evolved to the current state. I had to learn the structure of such projects and how model, DAO, service, controller and views connect to each other and work.<br>  
					Initially I had some issues with annotations for DAO and service layers, but was able to solve them quickly. After that connection between views (JSP),  controllers and data handling was easy. I have tried to put all business logic in the service layer. DAO layer is only responsible for the data input and extraction from the database. Controller classes only direct the project flow and pass data to service classes. All DAO and service classes have interfaces.<br>
					Understanding the servlet.xml, web.xml and pom.xml (I use Maven for dependencies) too some time. Loading resources (CSS, JS) and saving files in folder on the server too some time in set up in those files. All external Javascript files are loaded from CDN servers.<br>       
					I spend some time (~ 6 hours) on multiple files upload and direct add/edit/delete of answers. This was a bit challenging, but was solved with the help of wrapper class that puts all posted data (answers and attached file names) in lists. <br>
					I have lost quite some time (~12 hours) linking surveys and users tables with Hibernate and annotations. I ended having this working as separate small project before I managed to transfer this to the main project. I was getting 400 bad request server error, which is undefined and hard to track until I found out that with the help of log4j I can find the reason for this error (all data is passed as String by Spring MVC, so it needed custom property editor or some data binder to match the posted data with the expected object data). After I was able to find out the reason for this error it was solved with the help of one constructor that accepts one String parameter.<br> 
					Apart from these two more significant problems I was able to code everything else without too much extra work.<br><br>        
					
					<strong>Total time spend on front end: ~ 16 hours</strong><br>
					Java doesn't have associative arrays which is something I'm quite used to in PHP, so I had issues finding the right data structure for the data. Front end uses LinkedList with iterator because questions can only go forward or backward by one. One problem to solve was that iterator returns the same element when direction is changed, but with an addition of one parameter everything is working as expected.<br><br>
					
					<strong>Total time spend on Class Diagram: ~ 4 hours</strong><br>
					I have never worked with Spring MVC, Hibernate, JSTL and I have never created class diagram. Everything involved in this project is with the help of online tutorials and documentation.<br><br>
					
					<strong>Known issues:</strong><br> 
					Project doesn't include security and data checks and URLs validation and prevention of server errors because of wrong URL or missing parameters.<br><br>     
					When edited users assigned to survey don't show as selected. Data is present in the bean passed to JSP, but this is probably related to similar issue I had with linking these tables<br><br>
					Some minor bugs related to redirect after delete/save or preselecting default value when question/answer is created. Given the project requirements I didn't want to put too much extra work is solving all the small bids which would be obviuos issues if this project had to be put in actual use.<br><br>
					Data store in database for some filled survey is not loaded in Submitted surveys. Didn't have enough time to this also.<br><br>    
					
					<strong>Total time spend on project:  ~ 70 hours</strong><br><br><br><br>
					
					<strong>How to set up</strong><br>
					I have used MySQL server. You can set your logins in spring-servlet.xml<br>
					Parameter for server path to store images is set in web.xml<br><br><br><br>        
				</p> 
			</div>
		</div>		
	</div>
	
	<!-- Footer -->
	<%@ include file="./layout/footer.jsp" %>
</body>
</html>
