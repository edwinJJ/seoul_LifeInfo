<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<spring:url value="/resources/css/logError.css" var="mainCSS" />
		<link href="${mainCSS}" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<script>
		function log() {
		 		var data1 = $("#id").val();
		 		var data2 = $("#password").val();
		 		
				$.ajax({
							type: 'POST',
							url: "/info/logIn",
							headers:{
								"Content-Type" : "application/json",
								"X-HTTP-Method-Override":"POST",
							},
							dataType:'text',
							data: JSON.stringify(
								{id : data1, password : data2}		
							),
							success : function(result) {
								console.log(result);
								if(result==null || result==""){
									location.replace("/info/logError"); 
								}else{
									sessionStorage.setItem('name', result);
									location.replace("/info/main/board/write")
								}
							},
							error : function(result){
								console.log(result);
								console.log("error!!!!");
							}
				});	
		}
</script>	
		
       <div id="header"></div><h1><a href="/info" style="text-decoration:none ">Seoul Life Information</a></h1></div>			
			<p><input id='id' type='text' placeholder='ID'></p>
			<p><input id='password' type='text' placeholder='PASSWORD'></p>
			<input type='button' value='log in' onclick='log();'>
			<a href='http://localhost:9999/info/join'>join us</a>
</body>
</html>