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
    <link href='<resources:url value="/resources/css/front.css"/>' rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>    
	<title>Front End</title>
</head>
<body>
	<!-- Main Container -->
	<div class="container" style="max-width: 750px">
		
		<!-- Page code -->
		<div class="panel panel-default survey"> 
		
		<c:set var="action" value="next"/>
		<c:if test = "${ isLast }">
			<c:set var="action" value="save"/>
		</c:if>
		<form id="answerFrm" action="${action}" method="POST" class="form-horizontal answerFrm">
			<input type="hidden" id="qid" name="qid" value="${node.question.id}" />		
			<input type="hidden" id="dir" name="dir" value="${direction}" />
			<header class="panel-heading surveyHead">
				<p class="panel-title surveyTitle">${surveyData.survey.name}</p>
				<p class="panel-title surveyDescription">${surveyData.survey.description}</p>
				<div class="panel-heading surveyUser">logged as: ${surveyData.user.fName} ${surveyData.user.lName}</div>
			</header>		
		
			<div class="panel-body surveyBody">
				<p class="panel-title questionTitle">${node.question.title}</p>	
				<p class="panel-title questionDescription">
					${node.question.description}
					<c:if test = "${not empty node.question.filepath}">
						(<a class="viewFile" href="<resources:url value="/resources/upload/questions/${node.question.filepath}"/>" target="_blank" >view file</a>)
					</c:if>						
				</p>
				
				<c:set var="required" value=""/>
				<c:if test = "${node.question.is_required == 'T'}"><c:set var="required" value='class="required"'/></c:if>
				
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
							       <input type="radio" value="${answersList.id}" name="answer[${node.question.id}][]" id="questionAnswer${node.question.id}" ${checked} ${required} >
								   <label for="questionAnswer${answersList.id}">
										${answersList.title}																					
								   </label>
							    </c:when>
							    <c:when test="${node.question.type == 'multi'}">
							        <input type="checkbox" value="${answersList.id}" name="answer[${node.question.id}][]" id="questionAnswer${node.question.id}" ${checked} ${required} >
									<label for="questionAnswer${answersList.id}">
										${answersList.title}																					
									</label>
							    </c:when>
							</c:choose>							
						</li>
					</c:forEach>	
					</ul><!-- /.list-group -->
					<div><label for="answer[${node.question.id}][]" class="error" style="display:none;"></label></div>
				</div>
			</div>
			
			<footer class="surveyFooter">
				<div class="formActions">
					<div class="row">
						<div class="col-sm-6">
					        <c:if test = "${ !isFirst }">
					        	<a class="btn btn-default btnPrimary" href="<resources:url value="/front/prev?dir=bck"/>" >Back</a>
					        </c:if>
				        </div>
				        <div class="col-sm-6 right" style="text-align: right;">
					        <c:if test = "${ !isLast }">
					        	<input type="button" id="btnNext" class="btn btn-default btnPrimary" value="Next" />
					        </c:if>						
					        <c:if test = "${ isLast }">
					        	<input type="submit" class="btn btn-default btnPrimary" value="Finish" />
					        </c:if>			
				        </div>
			        </div>				
				</div>
			</footer>			
			</form>
		</div>	
	</div>	
    <script lang="javascript">
    	$("#btnNext").click(function(){
    		$("#dir").val("frw");
    		$("#answerFrm").submit();
    	});

    	$(document).ready(function() {
    		$("#answerFrm").validate();
    	});    	
    </script>	
</body>
</html>