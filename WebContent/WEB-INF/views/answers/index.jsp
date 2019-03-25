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
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>    
    <script type="text/javascript">
    	var appURL = '<resources:url value="/" />';
    </script>
	<title>All Answers</title>
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
				<div class="col-lg-6">&nbsp;</div>
				<div class="col-lg-6">
					<div class="col-lg-4" style="text-align: right;"><label for="question_id" style="line-height: 36px;">Select question:</label></div>
					<div class="col-lg-8">
						<select class="form-control" id="question_id">
							<c:forEach var="question" items="${questions}">
								<option value="${question.id}" <c:if test = "${ qid == question.id }">selected="selected"</c:if>>${question.title}</option>
							</c:forEach>
						</select> 
					</div>
				</div>
			</div>
		</div>			
		<!-- Page code -->

			<div>
				<form:form action="save" modelAttribute="answersListWrapper" method="POST" cssClass="form-horizontal" enctype="multipart/form-data">
				<input type="hidden" name="sid" id="sid" value="${sid}" />
				<input type="hidden" name="qid" id="qid" value="${qid}" /> 
				<input type="hidden" name="delete_answers" id="delete_answers" value="" />
				
				<div class="answer-container">
					<div class="answer-num-container">
						<div class="row">
							<div class="col-lg-1">&nbsp;</div>
							<div class="col-lg-6"><label for="inputTitle">Title</label></div>
							<div class="col-lg-4"><label for="inputFile">File</label></div>
						</div>
									
						<c:forEach items="${answersListWrapper.answers}" var="answer" varStatus="status" >
							<div class="answer-details">
								<div class="row"> 
						        	<div class="form-group">
						        		<div class="col-lg-1"><a class="btn btn-default btn-delete-answer" data-id="${answer.id}">delete</a></div>
						        		<input type="hidden" name="answers[${status.index}].id" value="${answer.id}" />
					            		<input type="hidden" name="answers[${status.index}].question_id" value="${qid}" />
										<div class="col-lg-6"><div class="form-group"><input type="text" name="answers[${status.index}].title" value="${answer.title}" class="form-control" /></div></div>
										<div class="col-lg-4" style="padding-left : 12px">
											<input type="file" name="files[${status.index}]" />
											<input type="hidden" name="answers[${status.index}].filepath" value="${answer.filepath}" />
											<c:if test = "${not empty answer.filepath}">
            									${answer.filepath} 
            									<a class="delete_link" href="<resources:url value="/answers/deletefile?sid=${sid}&qid=${qid}&aid=${answer.id}"/>" onclick="if(!confirm('Are you sure you want to delete this file?')) return false;">Delete uploaded file</a>
            								</c:if>
										</div>
						        	</div>
						        </div>			    
					        </div>
						</c:forEach>
					</div>
				</div>									
				<div> 
					<div id="submenu-btn">
						<button class="btn btn-default submenu-btn" id="btn-add-answer">Add new answer</button>
					</div>
				</div>					
		        <div class="form-group">
		            <div class="col-xs-offset-2 col-xs-10">
			    		<input type="submit" value="Save" class="btn btn-primary save" />
	            	</div>
	        	</div>	      
				</form:form>
				
				<div class="answer-clone" style="display: none;">
					<div class="answer-details">
						<div class="row"> 
				        	<div class="form-group">
				        		<div class="col-lg-1"><a class="btn btn-default btn-delete-answer">delete</a></div>
				            	<input type="hidden" name="answers[{INDEX}].question_id" value="${qid}" /> 
								<div class="col-lg-6"><div class="form-group"><input type="text" name="answers[{INDEX}].title" value="" class="form-control" /></div></div>
								<div class="col-lg-4" style="padding-left : 12px;">
									<input type="file" name="files[{INDEX}]" />
									<input type="hidden" name="answers[{INDEX}].filepath" value="" />
								</div>
					        </div>
					    </div>    		    
			        </div>		
				</div>				
			</div>	
	</div>
	
	<!-- Footer -->
	<%@ include file="../layout/footer.jsp" %>
	<script lang="javascript">
    	$("#btn-add-answer").click(function(e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}    		
			var len = $(".answer-container").find(".answer-details").length,
			clone = $(".answer-clone").clone(),
			index = len;
			
			var cloneHtml = clone.html().replace(/\{INDEX\}/g, index);
			$(".answer-num-container").append(cloneHtml);
	   	});
    	
    	$(".btn-delete-answer").click(function(e) { 
				if (e && e.preventDefault) {
					e.preventDefault();
				}
				var div_el = $(this).closest(".answer-details");
				var answer_id = $(this).data("id");
				var deleted_answers = "";
				
				div_el.css("backgroundColor", "#FFB4B4").fadeOut("slow", function () {
					deleted_answers = $("#delete_answers").val();
					if(deleted_answers == "") {
						$("#delete_answers").val(answer_id);
					} else {
						$("#delete_answers").val(deleted_answers + "," + answer_id);
					}
					div_el.remove();
				});
    	});
    	
	    $("#question_id").change(function() {
            window.location.href = appURL + 'answers/index?sid=' + $("#sid").val() + '&qid=' + $(this).val();
	   	});
    	
	</script>    	
</body>
</html>