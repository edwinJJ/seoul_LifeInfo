<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
		<spring:url value="/resources/css/main.css" var="mainCSS" />
		<link href="${mainCSS}" rel="stylesheet" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<title>seoul life information</title>
</head>

	<%
	    Object Name =  session.getValue("name");
		Name = (String) Name; 
	%>
	<script>
		
					function log() {
					 		var data1 = $("#id").val();
					 		var data2 = $("#password").val();
					 		
					 		
							$.ajax({
										type: 'POST',
										url: "logIn",
										headers:{
											"Content-Type" : "application/json",
											"X-HTTP-Method-Override":"POST",
										},
										dataType:'JSON',
										data: JSON.stringify(
											{id : data1, password : data2}		
										),
										success : function(name) {
											sessionStorage.setItem("name",name);
											alert("login complete!");
											location
											$("#showdata").html("");
										},
										error : function(result){
										},
										async : false
							});	
					}
					 	
													
	</script>
<body>
	<header>
			<h1><a href="/info" style="text-decoration:none ">Seoul Life Information</a></h1>
	</header>
	<nav style="display: inline;">
			   <ul>지하철</ul>
			   <ul>버스</ul>
			   <ul>날씨</ul>
			   <ul>미세먼지</ul>
			   <ul>게시판</ul>
	</nav>
	<article>
		<div id="logIn">			
			<script>
				 		var Name = "<%=Name%>" ;
						if(Name == "null"){  
								var	lines = "<p><input id='id' type='text' placeholder='ID'></p>";
									lines += "<p><input id='password' type='text' placeholder='PASSWORD'></p>";
									lines += "<input type='button' value='log in' onclick='log();'>";
									lines += "<a href='http://localhost:9999/info/join'>join us</a>";				
						   		document.write(lines);
				      	}
				        else{document.write("안녕하세요 "+ Name + "님");}    
			</script>	
		</div>
	</article>  
</body>
</html>