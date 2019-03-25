<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="resources"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link href='<resources:url value="/resources/css/style.css"/>' rel="stylesheet" />
	<title>${manageQuestion} Question</title>
</head>

<body>
	<!-- Header -->
	<%@ include file="../layout/header.jsp" %>
	
	<!-- Main Container -->
	<div class="container">
		
		<!-- Menu -->
		<%@ include file="../layout/menu.jsp" %>
		
		<!-- Page code -->
		<div class="row">
			<div class="col-lg-offset-2 col-lg-10"><h3>${manageQuestion} Question</h3></div>
		</div>
		<div class="row">&nbsp;</div>
		<form:form action="save" modelAttribute="question" method="POST" cssClass="form-horizontal" enctype="multipart/form-data">
			<form:hidden path="id" />
	        <div class="form-group">
	            <label for="inputSurveyID" class="control-label col-xs-2">Survey</label>
	            <div class="col-xs-6">
					<form:select path="survey_id" cssClass="form-control">
					    <form:options items="${surveys}" itemLabel="name" itemValue="id" />
					</form:select>	            
	            </div>
	        </div>			
	        <div class="form-group">
	            <label for="inputTitle" class="control-label col-xs-2">Title</label> 
	            <div class="col-xs-6">
	                <form:input type="text" path="title" cssClass="form-control" id="inputTitle" placeholder="Title" required="required" /> 
	            </div>
	        </div>		    
	        <div class="form-group">
	            <label for="inputTitle" class="control-label col-xs-2">Description</label>
	            <div class="col-xs-6">
	                <form:textarea path="description" cssClass="form-control" id="inputDescription" placeholder="Description" required="required" />
	            </div>
	        </div>
	        <div class="form-group">
	            <label for="inputType" class="control-label col-xs-2">Type</label>
	            <div class="col-xs-6">
					<form:select path="type" cssClass="form-control">
						<form:options items="${types}" />
					</form:select>	            
	            </div>
	        </div>
	        <div class="form-group">
	            <label for="inputRequired" class="control-label col-xs-2">Is Required</label>
	            <div class="col-xs-6">
					<form:select path="is_required" class="form-control">
						<form:options items="${required}" />
					</form:select>	            
	            </div>
	        </div>	        	       
	        <div class="form-group">
	            <label for="inputFile" class="control-label col-xs-2">File</label>
	            <div class="col-xs-6">
	            	<input type="file" name="question_file"/><br> 
	            	<c:if test = "${not empty question.filepath}">
	            		${question.filepath} 
	            		<a class="delete_link" href="<resources:url value="/question/deletefile?qid=${question.id}"/>" onclick="if(!confirm('Are you sure you want to delete this file?')) return false;">Delete uploaded file</a>
	            	</c:if>
	            </div>
	        </div>	        
	         
	        <div class="form-group">
	            <div class="col-xs-offset-2 col-xs-10">
			    	<input type="submit" value="Save" class="btn btn-primary save" />
	            </div>
	        </div>	      
		</form:form>
	</div>
	
	<!-- Footer -->
	<%@ include file="../layout/footer.jsp" %>
</body>
</html>