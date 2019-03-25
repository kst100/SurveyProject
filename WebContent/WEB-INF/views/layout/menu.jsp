		<div data-example-id="navbar-button" class="topmenu">
		    <nav class="navbar navbar-default">
		      <div class="container-fluid">
		        <div class="navbar-header">
		          <button aria-expanded="false" data-target="#topmenu-navbar-collapse-btn" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
		            <span class="sr-only">Toggle navigation</span>
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
		          </button>
		        </div> 
		        <div id="topmenu-navbar-collapse-btn" class="collapse navbar-collapse">
		        	<a href='<resources:url value="/"/>' class="btn btn-default navbar-btn">
		        		<div class="link-nav-div"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</div>
		        	</a>		        
		        	<a href='<resources:url value="/survey/index"/>' class="btn btn-default navbar-btn">
		        		<div class="link-nav-div"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> Surveys</div>
		        	</a>
		        	<a href='<resources:url value="/question/index"/>' class="btn btn-default navbar-btn">
		        		<div class="link-nav-div"><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span> Questions</div>
		        	</a>		        	
		        	<a href='<resources:url value="/user/index"/>' class="btn btn-default navbar-btn">
		        		<div class="link-nav-div"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Users</div>
		        	</a>
		        	<a href='<resources:url value="/submitted/index"/>' class="btn btn-default navbar-btn">
		        		<div class="link-nav-div" style="padding-top:4px">Submitted<br>Surveys</div>
		        	</a>		        	
		        	<a href='<resources:url value="/report/index"/>' class="btn btn-default navbar-btn">
		        		<div class="link-nav-div"><span class="glyphicon glyphicon-tasks" aria-hidden="true"></span> Reports</div>
		        	</a>
		        </div>
		      </div>
		    </nav>
		</div>	
	
		<div class="panel panel-default">
		  <div class="panel-body">
			<%
				String note = "";
      			String requestURI = request.getRequestURI();
				if( requestURI.contains( "home" ) ){
					note = "<div class=\"col-lg-12\" style=\"text-align: center;\"><h2>Project Summary</h2></div>";
				} else if( requestURI.contains( "surveys" ) ){
					note = "Surveys Page description";
				} else if( requestURI.contains( "questions" ) ){
					note = "Questions Page description";
				} else if( requestURI.contains( "answers" ) ){
					note = "Answers Page description";
				} else if( requestURI.contains( "users" ) ){
					note = "Users Page description";
				} else if( requestURI.contains( "reports" ) ){
					note = "Reports Page description";
				} else if( requestURI.contains( "submitted" ) ){
					note = "Submitted Surveys Page description";
				}				
			%>
			<%= note %>	
		  </div>
		</div>	