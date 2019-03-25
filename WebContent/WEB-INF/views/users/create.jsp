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
	<title>${manageUser} User</title>
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
			<div class="col-lg-offset-2 col-lg-10"><h3>${manageUser} User</h3></div>
		</div>
		<div class="row">&nbsp;</div>
		<form:form action="save" modelAttribute="user" method="POST" cssClass="form-horizontal">
			<form:hidden path="id" />
	        <div class="form-group">
	            <label for="inputFName" class="control-label col-xs-2">First Name</label>
	            <div class="col-xs-6">
	                <form:input type="text" path="fName" cssClass="form-control" id="inputFName" placeholder="First Name" required="required" />
	            </div>
	        </div>
	        <div class="form-group">
	            <label for="inputLName" class="control-label col-xs-2">Last Name</label>
	            <div class="col-xs-6">
	                <form:input type="text" path="lName" cssClass="form-control" id="inputLName" placeholder="Last Name" required="required" />
	            </div>
	        </div>	
	        <div class="form-group">
	            <label for="inputEmail" class="control-label col-xs-2">Email</label>
	            <div class="col-xs-6">
	                <form:input type="text" path="email" cssClass="form-control" id="inputEmail" placeholder="Email" required="required" />
	                <div id="inputEmailErr" style="display:none;">Email already exists</div>
	            </div>
	        </div>	 
	        <div class="form-group">
	            <label for="inputPhone" class="control-label col-xs-2">Phone</label>
	            <div class="col-xs-6">
	                <form:input type="text" path="phone" cssClass="form-control" id="inputPhone" placeholder="Phone" required="required" />
	            </div>
	        </div>		               	        		    
	        <div class="form-group">
	            <label for="inputAddress" class="control-label col-xs-2">Address</label>
	            <div class="col-xs-6">
	                <form:textarea path="address" cssClass="form-control" id="inputAddress" placeholder="Address" required="required" />
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
	
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script lang="javascript">
    	var appURL = '<resources:url value="/" />';
    	$("#inputEmail").focusout(function(){
            $.ajax({
                url : appURL + 'user/checkemail?email=' + $(this).val(),
                success : function(data) {
                	if (data == 100){
                		$('#inputEmailErr').show();	
                	} else if(data == 200){
                		$('#inputEmailErr').hide();
                	}
                    //$('#inputEmailErr').html(data);
                }
            });    		
    	});
    </script>
	
</body>
</html>