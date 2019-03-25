<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="resources"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link href='<resources:url value="/resources/css/style.css"/>' rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>    
    <script type="text/javascript">
    	var appURL = '<resources:url value="/" />';
    	var properties = [
    		'id',
    		'fName',
    		'lName',
    		'email',
    		'phone'
    	];   	
    </script>
    <script type="text/javascript" src='<resources:url value="/resources/js/admin.js"/>'></script>
	<title>All Users</title>
</head>

<body>
	<!-- Header -->
	<%@ include file="../layout/header.jsp" %>
	
	<!-- Main Container -->
	<div class="container">
		
		<!-- Menu -->
		<%@ include file="../layout/menu.jsp" %>
		
		<!-- SubMenu -->
		<div id="submenu-btn">
			<a class="btn btn-default submenu-btn" href="<resources:url value="/user/create"/>">Add new user</a>
		</div>	
	
		<!-- Page code -->
		<!-- Table from https://codepen.io/nathancockerill/pen/OQyXWb  -->
		<div class="table">
			<div class="table-header">
				<!--  TODO Add default order class to ID -->
				<div class="header__item"><a id="id" class="filter__link filter__link--number" href="#">ID</a></div>
				<div class="header__item"><a id="fName" class="filter__link" href="#">First Name</a></div>
				<div class="header__item"><a id="lName" class="filter__link" href="#">Last Name</a></div>
				<div class="header__item"><a id="email" class="filter__link" href="#">Email</a></div>
				<div class="header__item"><a id="phone" class="filter__link" href="#">Phone</a></div>
				<div class="header__item"></div>
			</div>
			<div class="table-content">
				<c:forEach var="user" items="${users}">	 
					<div class="table-row">		
						<div class="table-data">${user.id}</div>
						<div class="table-data">${user.fName}</div>
						<div class="table-data">${user.lName}</div>
						<div class="table-data">${user.email}</div>
						<div class="table-data">${user.phone}</div>
						<div class="table-data" style="text-align: right; padding-right: 10px;">
							<a class="btn btn-default btn-icons" href="update?id=${user.id}"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
							<a class="btn btn-default btn-icons" href="delete?id=${user.id}" onclick="if(!confirm('Are you sure you want to delete this user? \n\nNote this will also delete all sumissions by this user!')) return false;"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a>
						</div>
					</div>
				</c:forEach>	
			</div>	
		</div>
	</div>
	
	<!-- Footer -->
	<%@ include file="../layout/footer.jsp" %>
</body>
</html>