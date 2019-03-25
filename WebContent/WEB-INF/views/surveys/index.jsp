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
    		'name',
    		'description',
    		'created'
    	];    	
    </script>
    <script type="text/javascript" src='<resources:url value="/resources/js/admin.js"/>'></script>
	<title>All Surveys</title>
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
			<a class="btn btn-default submenu-btn" href="<resources:url value="/survey/create"/>">Add new survey</a>
		</div>	
	
		<!-- Page code -->
		<!-- Table from https://codepen.io/nathancockerill/pen/OQyXWb  -->
		<div class="table">
			<div class="table-header">
				<!--  TODO Add default order class to ID -->
				<div class="header__item_small"><a id="id" class="filter__link filter__link--number" href="#">ID</a></div>
				<div class="header__item"><a id="name" class="filter__link" href="#">Survey</a></div>
				<div class="header__item_large"><a id="description" class="filter__link" href="#">Description</a></div>
				<div class="header__item"><a id="created" class="filter__link" href="#">Expiration Date</a></div>
				<div class="header__item_large_right"></div>
			</div>
			<div class="table-content">
				<c:forEach var="survey" items="${surveys}">	 
					<div class="table-row">		
						<div class="table-data-small">${survey.id}</div>
						<div class="table-data">${survey.name}</div>
						<div class="table-data-large">${survey.description}</div>
						<div class="table-data">${survey.expirationDate}</div>
						<div class="table-data-large-right">
							<a class="btn btn-default table-btn" href="<resources:url value="/front/preview?sid=${survey.id}"/>" target="_blank">Preview</a>
							<a class="btn btn-default table-btn" href="<resources:url value="/question/index?sid=${survey.id}"/>">Questions</a>
							<a class="btn btn-default btn-icons" href="update?id=${survey.id}"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
							<a class="btn btn-default btn-icons" href="delete?id=${survey.id}" onclick="if(!confirm('Are you sure you want to delete this survey? \n\nNote this will also delete all questions and sumissions related to it!')) return false;"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a>
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