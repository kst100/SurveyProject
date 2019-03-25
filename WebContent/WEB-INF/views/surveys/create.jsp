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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/css/bootstrap-multiselect.css" />	
	
    <link href='<resources:url value="/resources/css/style.css"/>' rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/js/bootstrap-multiselect.min.js"></script>
    <script type="text/javascript" src='<resources:url value="/resources/js/admin.js"/>'></script>
    <script type="text/javascript">var appURL = '<resources:url value="/" />'</script>
	<title>${manageSurvey} Survey</title>
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
			<div class="col-lg-offset-2 col-lg-10"><h3>${manageSurvey} Survey</h3></div>
		</div>
		<div class="row">&nbsp;</div>
		<form:form action="save" modelAttribute="survey" method="POST" cssClass="form-horizontal">
			<form:hidden path="id" />
	        <div class="form-group">
	            <label for="inputTitle" class="control-label col-xs-2">Title</label>
	            <div class="col-xs-6">
	                <form:input type="text" path="name" cssClass="form-control" id="inputTitle" placeholder="Title" required="required" />
	            </div>
	        </div>		    
	        <div class="form-group">
	            <label for="inputTitle" class="control-label col-xs-2">Description</label>
	            <div class="col-xs-6">
	                <form:textarea path="description" cssClass="form-control" id="inputDescription" placeholder="Description" required="required" />
	            </div>
	        </div>
	         
	        <div class="form-group">
	            <label for="inputExpiration" class="control-label col-xs-2">Expiration Date/Time</label>
	            <div class="col-xs-3">
	                <div class='input-group date' id='datetimepicker_container'>
	                    <form:input type="text" id="datepicker" class="form-control" path="expirationDate" placeholder="yyyy-mm-dd hh:ii"/>
	                    <span class="input-group-addon">
	                        <span class="glyphicon glyphicon-calendar"></span>
	                    </span>
	                </div>
	            </div>
	        </div>
	        <div class="form-group">
	            <label for="inputUsers" class="control-label col-xs-2">Users</label>
	            <div class="col-xs-6">
	            	<form:select path="usersPerSurvey" itemValue="id" itemLabel="fName" items="${usersPerSurvey}" class="form-control" multiple="multiple" />
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
	<script type="text/javascript">
	    $(document).ready(function() {
	        $('#usersPerSurvey').multiselect();
	    });
	</script>	
</body>
</html>