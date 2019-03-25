<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="resources"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link href='<resources:url value="/resources/css/front.css"/>' rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>    
	<title>Front End</title>
</head>
<body>
	<!-- Main Container -->
	<div class="container">
		
		<!-- Page code -->
		<div class="row">
			<div class="col-lg-offset-2 col-lg-10"><h3>Login Form</h3></div>
		</div>
		<div class="row">&nbsp;</div>
		<form action="doLogin" id="userLogin" method="POST" class="form-horizontal">
			<input type="hidden" name="sid" id="sid" value="${sid}" />
	        <div class="form-group">
	            <label for="inputEmail" class="control-label col-xs-2">Email</label>
	            <div class="col-xs-3">
	                <input type="text" name="email" class="form-control" id="email" placeholder="Email" required="required" />
	            </div>
	        </div>
	        <div class="form-group">
	            <label for="inputEmail" class="control-label col-xs-2">Password</label>
	            <div class="col-xs-3">
	                <input type="password" class="form-control" name="pass" id="pass" placeholder="*****" required="required" />
	            </div>
	        </div>		 
			<%
				String display = "none";
			    if (request.getParameter("err") != null && request.getParameter("err").equals("E1")) {
			        display = "block";
			    }
			%>	
			<div class=".col-xs-3 .offset-xs-2 inputLoginsErr" style="display:<%= display %>;">Incorrect Logins</div>
	        <div class="form-group">
	            <div class="col-xs-offset-2 col-xs-10">
			    	<input type="submit" value="Login" class="btn btn-primary save" />
	            </div>
	        </div>	      
		</form>
	</div>	
	
</body>
</html>