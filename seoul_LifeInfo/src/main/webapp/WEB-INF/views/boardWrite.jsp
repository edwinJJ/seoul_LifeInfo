<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
		<spring:url value="/resources/css/boardWrite.css" var="boardWriteCSS" />
		<link href="${boardWriteCSS}" rel="stylesheet" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery.form.js"></script>
		<title>seoul life information</title>
</head>
	<script>
					var Name = "";
					var logoutButton = "<p><a id='logoutButton' onclick='logout()'>log out</a></p>"
					
					if(sessionStorage.getItem('name')){
						Name = sessionStorage.getItem('name');
					}else{
						alert('로그인을 해야합니다.');
						location.replace("/info/main/board/login");
					}				
					
					
					function logout() {
										sessionStorage.clear();
										location.replace("/info/main/board/1");
					}
					
					
					function insert() {
						console.log("write()실행");
						
				 		var data1 = $("#title").val();
				 		var data2 = $("#description").val();
				 		var data3 = Name;
				 		var data4 = $("input[id=file]");

						$.ajax({
							type: 'POST',
							url: "/info/main/board/write",
							headers:{
								"Content-Type" : "application/json",
								"X-HTTP-Method-Override":"POST",
							},
							dataType: 'text',
							data: JSON.stringify(
								{title: data1, description: data2, author: data3, file: data4}		
							),
							success : function(result) {
								if(result == "true") {
									alert("게시글 작성이 완료되었습니다.");
									location.replace("/info/main/board/1");
								} else {
									alert("게시글 작성 실패");
								}
							},
							error : function(result){
								alert("error");
							}			
						});
				 	}
					
					
					function test() {
						 	$('#ajaxform').ajaxForm({  beforeSubmit: function (data, frm, opt) { alert("전송전!!"); return true; },  
							 							success: function(responseText, statusText){ alert("전송성공!!"); },  
							 							error: function(){ alert("에러발생!!"); } 
							 });
					}
													
	</script>
<body style="background-color: skyblue;">
	<header>
			<a href="/info/1" style="color: white;
								   font-family: fantasy;
								   font-size: 50px; 	
								   text-decoration:none;
								   padding-left: 40px;
								   padding-top:10px;">Seoul Life Information</a>
	</header>
	<nav style="color:white;">
			  <ul><a href='/info/main/subway'>지하철</a></ul>
			   <ul><a href='/info/main/bus'>버스</a></ul>
			   <ul><a href='/info/main/weather'>날씨</a></ul>
			   <ul><a href='/info/main/dust'>미세먼지</a></ul>
			   <ul><a href="/info/main/board/1">게시판</a></ul>
	</nav>
	<article>
		<div id="logIn" style="float: right;color: white;">			
			<script>
						if(Name == ""){  
								var	lines = "<p><input id='id' type='text' placeholder='ID'></p>";
									lines += "<p><input id='password' type='text' placeholder='PASSWORD'></p>";
									lines += "<input id='loginButton' type='button' value='log in' onclick='log();'>";
									lines += "&nbsp; <a href='/info/join'>join us</a>";				
						   		document.write(lines);
				      	}
				        else{
				        		document.write("안녕하세요 "+ Name + "님" + logoutButton);
				       	}    
			</script>	
		</div>
		<h1 style="font-family: fantasy">BOARD</h1>
		<p>작성자:<script>document.write(Name);</script></p>
		<p>제목: <input type='text' id='title' placeholder='title'></p>
		<p>본문</p> <textarea id='description' placeholder='description'></textarea>
		<p><input type='button' value="작성" onclick='insert();'></p>
		
	</article>  
</body>
</html>
