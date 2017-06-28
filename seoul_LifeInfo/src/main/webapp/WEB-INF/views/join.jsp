<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
		<spring:url value="/resources/css/join.css" var="joinCSS" />
		<link href="${joinCSS}" rel="stylesheet" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<title>seoul life information</title>
</head>
<script>
 	function join() {
 		var data1 = $("#ide").val();
 		var data2 = $("#pass").val();
 		var data3 = $("#name").val();
 		var data4 = $("#birth").val();
 		var data5 = $("#phoneNumber").val();
 		var data6 = $("#address").val();
		$.ajax({
			type: 'POST',
			url: "join",
			headers:{
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override":"POST",
			},
			dataType: 'text',
			data: JSON.stringify(
				{id : data1, password : data2, name : data3, birth : data4, 
					phoneNumber : data5, address : data6}		
			),
			success : function(result) {
				if(result == "true") {
					sessionStorage.setItem('name', data3);
					alert("회원가입이 완료되었습니다.");
					location.replace("/info/1");
				} else {
					alert("회원가입 실패");
				}
			},
			error : function(result){
				alert("error");
			}			
		});
 	}
 	
 	function onKeyDownJoin()
	{
	     if(event.keyCode == 13)
	     {
	          join();
	     }
	}
  </script>
  <body>
			
			<div id='joinDiv'>
				  <h1><a href="/info" style="text-decoration:none ">Seoul Life Information</a></h1>
				  <p> <input class='INPUT' id='ide' name='id' type='text' placeholder='ID'></p>
				  <p> <input class='INPUT' id='pass' name='password' type='password' placeholder='PASSWORD'></p>
				  <p><input class='INPUT' id='name'  type='text' placeholder='name'></p>
				  <p><input class='INPUT' id='birth'  type='text' placeholder='birth'></p>
				  <p> <input class='INPUT' id='phoneNumber' type='text' placeholder='phoneNumber'></p>
				  <p><input class='INPUT' id='address' type='text' placeholder='address' onkeydown='onKeyDownJoin();'></p>
				  <input id='joinButton' type='button' value='JOIN!' onclick="join();">
  			</div>
  			
  			
  </body>
</html>









