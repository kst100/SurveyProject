<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
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
    <script type="text/javascript" src='<resources:url value="/resources/js/admin.js"/>'></script>
	<title>View Submitted Survey</title>
</head>

<body>
	<!-- Header -->
	<%@ include file="../layout/header.jsp" %>
	
	<!-- Main Container -->
	<div class="container">
		
		<!-- Menu -->
		<%@ include file="../layout/menu.jsp" %>
		
	
		<!-- Page code -->
			<header class="panel-heading surveyHead">
				<p class="panel-title surveyTitle">${surveyData.survey.name}</p>
			</header>		
		
			<div class="panel-body surveyBody">
				<p class="panel-title questionTitle">${node.question.title}</p>	
				<p class="panel-title questionDescription">
					${node.question.description}
					<c:if test = "${not empty node.question.filepath}">
						(<a class="viewFile" href="<resources:url value="/resources/upload/questions/${node.question.filepath}"/>" target="_blank" >view file</a>)
					</c:if>						
				</p>
				<c:forEach var="node" items="${surveyData.questionsList}">
					<div class="pjSsQuestionBody">
					    <c:if test="${node.question.type == 'open'}">
							<label for="questionAnswer${answersList.id}">
								${answersList.title}																				
							</label>
							<c:set var="ansKey" value="open[${node.question.id}]"/>
					        <textarea style="width:100%; height: 150px;" name="open[${node.question.id}]" ${required}>${sessionScope[ansKey]}</textarea>
					        <div><label for="open[${node.question.id}]" class="error" style="display:none;"></label></div>
					    </c:if>					
					
						<ul class="list-group">
						<c:forEach var="answersList" items="${node.answers}">
							<li class="list-group-item">
								<c:set var="checked" value=""/>
								<c:set var="ansKey" value="answer[${node.question.id}][]"/>
								<c:if test = "${fn:containsIgnoreCase(sessionScope[ansKey], answersList.id)}"><c:set var="checked" value='checked="checked"'/></c:if>
								
								<c:choose>
								    <c:when test="${node.question.type == 'single'}">
								       <input type="radio" value="${answersList.id}" name="answer[${node.question.id}][]" id="questionAnswer${node.question.id}" ${checked} readonly="readonly"  >
									   <label for="questionAnswer${answersList.id}">
											${answersList.title}																					
									   </label>
								    </c:when>
								    <c:when test="${node.question.type == 'multi'}">
								        <input type="checkbox" value="${answersList.id}" name="answer[${node.question.id}][]" id="questionAnswer${node.question.id}" ${checked} readonly="readonly" >
										<label for="questionAnswer${answersList.id}">
											${answersList.title}																					
										</label>
								    </c:when>
								</c:choose>							
							</li>
						</c:forEach>	
						</ul><!-- /.list-group -->
					</div>
				</c:forEach>	
			</div>		

	</div>
	
	<!-- Footer -->
	<%@ include file="../layout/footer.jsp" %>
</body>
</html>