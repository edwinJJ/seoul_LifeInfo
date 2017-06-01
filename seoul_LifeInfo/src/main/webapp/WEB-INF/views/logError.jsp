<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
									url: "logIn",
									headers:{
										"Content-Type" : "application/json",
										"X-HTTP-Method-Override":"POST",
									},
									dataType:'JSON',
									data: JSON.stringify(
										{id : data1, password : data2}		
									),
									success : function(result) {
									},
									error : function(result){
									},
									async : false
								});
								
								location.href="/info/main";
						 	}
						 	
		function goPage() { location.href="/info/logTest"; }	
</script>	
            <h1>Seoul Life Information</h1>			
			<p><input id='id' type='text' placeholder='ID'></p>
			<p><input id='password' type='text' placeholder='PASSWORD'></p>
			<h5>등록된 아이디가 없거나 비밀번호가 틀렸습니다.</h5>
			<input type='button' value='log in' onclick='log()'>
			<a href='http://localhost:9999/info/join'>join us</a>
</body>
</html>