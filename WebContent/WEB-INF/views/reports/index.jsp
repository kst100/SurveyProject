<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    		'title'
    	];
    </script>
    <script type="text/javascript" src='<resources:url value="/resources/js/admin.js"/>'></script>
	<title>Report</title>
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
			<div class="col-lg-12">
				<div class="col-lg-8" style="text-align: right;"><label for="survey_id" style="line-height: 36px;">Survey filter:</label></div>
				<div class="col-lg-4">
					<select class="form-control" id="survey_id">
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
				<div class="header__item_report"><a id="title" class="filter__link" href="#">Question</a></div>
				<c:set var="string" value="ABCDEFGHIJKLMNOP"/>   
				<c:forEach var="i" begin="1" end="${answersCount}">
					<div class="header__item_list" style="flex:1 1 ${ 40 / answersCount }%;"><a id="${fn:substring(string, i-1, i)}" class="filter__link" href="#">${fn:substring(string, i-1, i)}</a></div>	 
				</c:forEach>	 			
			</div>
			<div class="table-content">
				<c:forEach var="question" items="${questions}">	 
					<div class="table-row">		
						<div class="table-data-report">${question.title}</div>
						<c:choose>
						    <c:when test="${question.type == 'open'}">
						    	<c:forEach var="i" begin="1" end="${answersCount}">
						    		<div class="table-data-list" style="flex:1 1 ${ 40 / answersCount }%;">-</div>
						    	</c:forEach>
						    </c:when>
						    <c:when test="${question.type == 'single'}">
								<c:set var="indx" value="0"/>						    
								<c:forEach var="questionReport" items="${questionsReport}">
									<c:if test = "${question.id == questionReport.question_id}">
										<div class="table-data-list" style="flex:1 1 ${ 40 / answersCount }%;">${questionReport.cnt}</div>
										<c:set var="indx" value="${indx + 1}"/>
									</c:if>	
								</c:forEach>
						    	<c:forEach var="i" begin="${indx+1}" end="${answersCount}">
						    		<div class="table-data-list" style="flex:1 1 ${ 40 / answersCount }%;">&nbsp;</div>
						    	</c:forEach>
						    </c:when>
						    <c:when test="${question.type == 'multi'}">
						    	<c:set var="indx" value="0"/>
								<c:forEach var="questionReport" items="${questionsReport}">
									<c:if test = "${question.id == questionReport.question_id}">
										<div class="table-data-list" style="flex:1 1 ${ 40 / answersCount }%;">${questionReport.cnt}</div>
										<c:set var="indx" value="${indx + 1}"/>
									</c:if>	
								</c:forEach>
						    	<c:forEach var="i" begin="${indx+1}" end="${answersCount}">
						    		<div class="table-data-list" style="flex:1 1 ${ 40 / answersCount }%;">&nbsp;</div>
						    	</c:forEach>														    
						    </c:when>
						</c:choose>		 					
					</div>
				</c:forEach>	
			</div>	
		</div>
	</div>
	
	<!-- Footer -->
	<%@ include file="../layout/footer.jsp" %>
	<script lang="javascript">
	    $("#survey_id").change(function() {
            window.location.href = appURL + 'report/index?sid=' + $(this).val();
	   	});
	</script>    	
</body>
</html>