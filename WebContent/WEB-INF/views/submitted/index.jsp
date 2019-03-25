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
    		'survey',
    		'user',
    		'created'
    	];    	
    </script>
    <script type="text/javascript" src='<resources:url value="/resources/js/admin.js"/>'></script>
	<title>Submitted Surveys</title>
</head>

<body>
	<!-- Header -->
	<%@ include file="../layout/header.jsp" %>
	
	<!-- Main Container -->
	<div class="container">
		
		<!-- Menu -->
		<%@ include file="../layout/menu.jsp" %>
		
	
		<!-- Page code -->
		<div class="table">
			<div class="table-header">
				<!--  TODO Add default order class to ID -->
				<div class="header__item_small"><a id="id" class="filter__link filter__link--number" href="#">ID</a></div>
				<div class="header__item_large"><a id="name" class="filter__link" href="#">Survey</a></div>
				<div class="header__item"><a id="description" class="filter__link" href="#">User</a></div>
				<div class="header__item"><a id="created" class="filter__link" href="#">Created Date</a></div>
				<div class="header__item"></div>
			</div>
			<div class="table-content">
				<c:forEach var="surveyAnswerDetails" items="${surveyAnswersDetails}">	 
					<div class="table-row">		
						<div class="table-data-small">${surveyAnswerDetails.id}</div>
						<div class="table-data-large">${surveyAnswerDetails.surveyTitle}</div>
						<div class="table-data">${surveyAnswerDetails.userName}</div>
						<div class="table-data">${surveyAnswerDetails.created}</div>
						<div class="table-data-large-right">
							<a class="btn btn-default table-btn" href="<resources:url value="/submitted/view?said=${surveyAnswerDetails.id}"/>">view</a>
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