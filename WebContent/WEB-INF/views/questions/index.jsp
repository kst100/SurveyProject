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
    		'title',
    		'type',
    		'survey'
    	];
    </script>
    <script type="text/javascript" src='<resources:url value="/resources/js/admin.js"/>'></script>
	<title>All Questions</title>
</head>

<body>
	<!-- Header -->
	<%@ include file="../layout/header.jsp" %>
	
	<!-- Main Container -->
	<div class="container">
		
		<!-- Menu -->
		<%@ include file="../layout/menu.jsp" %>
		
		<!-- SubMenu -->
		<div class="form-group">
		<div class="row">
			<div class="col-lg-6">
				<div id="submenu-btn">
					<a class="btn btn-default submenu-btn" href="<resources:url value="/question/create?sid=${sid}"/>">Add new question</a>
				</div>	
			</div>
			<div class="col-lg-6">
				<div class="col-lg-4" style="text-align: right;"><label for="survey_id" style="line-height: 36px;">Survey filter:</label></div>
				<div class="col-lg-8">
					<select class="form-control" id="survey_id">
						<option value="0">All</option>
						<c:forEach var="survey" items="${surveys}">
							<option value="${survey.id}" <c:if test = "${ sid == survey.id }">selected="selected"</c:if>>${survey.name}</option>
						</c:forEach>
					</select> 
				</div>
			</div>
		</div>
		</div>
		<!-- Page code -->
		<div class="table">
			<div class="table-header">
				<!--  TODO Add default order class to ID -->
				<div class="header__item"><a id="id" class="filter__link filter__link--number" href="#">ID</a></div>
				<div class="header__item"><a id="title" class="filter__link" href="#">Question</a></div>
				<div class="header__item"><a id="type" class="filter__link" href="#">Type</a></div>
				<div class="header__item"><a id="Survey" class="filter__link" href="#">Survey</a></div>
				<div class="header__item"></div>
			</div>
			<div class="table-content">
				<c:forEach var="question" items="${questions}">	 
					<div class="table-row">		
						<div class="table-data">${question.id}</div>
						<div class="table-data">${question.title}</div>
						<div class="table-data">${question.type}</div>
						<div class="table-data">${question.survey_id}</div>
						<div class="table-data" style="text-align: right; padding-right: 10px;">
							<c:if test = "${ question.type != 'open' }">
								<a class="btn btn-default table-btn" href="<resources:url value="/answers/index?sid=${question.survey_id}&qid=${question.id}"/>">Answers</a>
							</c:if>
							<a class="btn btn-default btn-icons" href="update?id=${question.id}"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
							<a class="btn btn-default btn-icons" href="delete?id=${question.id}" onclick="if(!confirm('Are you sure you want to delete this question? \n\nNote this will also delete all answers!')) return false;"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a>
						</div>
					</div>
				</c:forEach>	
			</div>	
		</div>
	</div>
	
	<!-- Footer -->
	<%@ include file="../layout/footer.jsp" %>
	<script lang="javascript">
	    $("#survey_id").change(function() {
            window.location.href = appURL + 'question/index?sid=' + $(this).val();
	   	});
	</script>    	
</body>
</html>