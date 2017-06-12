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
<script>
 	function join() {
 		var data1 = $("#id").val();
 		var data2 = $("#password").val();
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
					alert("회원가입이 완료되었습니다.");
					location.replace("/info");
				} else {
					alert("회원가입 실패");
				}
			},
			error : function(result){
				alert("error");
			}			
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
  <p>ID: <input id='id' name='id' type='text' placeholder='ID'></p>
  <p>password: <input id='password' name='password' type='text' placeholder='PASSWORD'></p>
  <p>닉네임: <input id='name'  type='text' placeholder='name'></p>
  <p>생년월일: <input id='birth'  type='text' placeholder='birth'></p>
  <p>전화번호: <input id='phoneNumber' type='text' placeholder='phoneNumber'></p>
  <p>집 주소: <input id='address' type='text' placeholder='address'></p>
  <input type='button' value='done' onclick="join();">
  
  </body>
</html>









