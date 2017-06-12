<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<html>
<head>
		<spring:url value="/resources/css/boardArticle.css" var="boardArticleCSS" />
		<link href="${boardArticleCSS}" rel="stylesheet" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<title>seoul life information</title>
</head>
	<script>
					var Name = "";
					var logoutButton = "<p><input type='button' value='log out' onclick='logout();' style='background-color: white; color:skyblue;'></p>"
					var Article;
					
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
												$("#logIn").html("안녕하세요" + result + "님" + logoutButton);
											}
										},
										error : function(result){
											console.log(result);
											console.log("error!!!!");
										}
							});	
					}
					
					
					function logout() {
										sessionStorage.clear();
										location.replace("/info");
					}
					
					
					function getArticle() {
						var articleNumber = "${articleNumber}";
						articleNumber = parseInt(articleNumber);
				        
						$.ajax({     
									type: 'POST',
									url: "/info/getArticle",
									headers:{
										"Content-Type" : "application/json",
										"X-HTTP-Method-Override":"POST",
									},
									dataType:'json',
									data: JSON.stringify(
											{articleNumber : articleNumber}		
										),
									success : function(result) {
										console.log(result);
										Article = result;
										console.log(Article);
									},
									error : function(result){
										console.log(result);
										console.log("error!!!!");
									},
									async: false
									
						});	
					} getArticle();
					
					if(sessionStorage.getItem('name')){
						Name = sessionStorage.getItem('name');
						if(Article[Name] == true){document.body.className = 'red';}
					}else{
					}				
					
					
					function likeUpdate() {
						var articleNumber = "${articleNumber}";
						articleNum = parseInt(articleNumber);
						$.ajax({     
									type: 'POST',
									url: "/info/likeUpdate",
									headers:{
										"Content-Type" : "application/json",
										"X-HTTP-Method-Override":"POST",
									},
									dataType:'json',
									data: JSON.stringify(
											{name: Name, articleNum : articleNum}		
										),
									success : function(result) {
										console.log(result);
										if(result == "true") {
											alert("좋아요!");
										} else {
											alert("좋아요 실패");
										}
									},
									error : function(result){
										console.log(result);
										console.log("error!!!!");
									},
						});	
					} 
					
					function likeCancel(){
						alert('Like is canceled');
					}
					
					
	</script>
<body style="background-color: skyblue;" class="white" id="BODY">
	<header>
			<a href="/info" style="color: white;
								   font-family: fantasy;
								   font-size: 50px; 	
								   text-decoration:none;
								   padding-left: 40px;
								   padding-top:10px;">Seoul Life Information</a>
	</header>
	<nav style="color:white;">
			   <ul>지하철</ul>
			   <ul>버스</ul>
			   <ul>날씨</ul>
			   <ul>미세먼지</ul>
			   <ul><a href="/info/main/board/1">게시판</a></ul>
	</nav>
	<article>
		<div id="logIn" style="float: right;color: white;">			
			<script>
						if(Name == ""){  
								var	lines = "<p><input id='id' type='text' placeholder='ID'></p>";
									lines += "<p><input id='password' type='text' placeholder='PASSWORD'></p>";
									lines += "<input id='loginButton' type='button' value='log in' onclick='log();'>";
									lines += "&nbsp; <a href='http://localhost:9999/info/join'>join us</a>";				
						   		document.write(lines);
				      	}
				        else{
				        		document.write("안녕하세요 "+ Name + "님" + logoutButton);
				       	} 
			</script>	
		</div>
			
		<h1 style="color: white;">자유게시판</h1>
		<div id="boardArticleMain">
			<div style="color: white;">
				<p>ArticleNumber: <script>document.write(Article["number"])</script></p>
				<p>Author: <script>document.write(Article["author"])</script></p>
				<p>Created: <script>document.write(Article["created"])</script></p>
			</div>
				<p style="font-size: 40px;"><script>document.write(Article["title"])</script></p>
			<div style="background-color: white; padding-left: 10px; padding-top: 10px; padding-bottom: 50px;">
				<p><script>document.write(Article["description"])</script></p>
			</div>			
			<p><div class="hearty" onclick="likeColor()"><script>if(Article["likes"]){document.write(Article["likes"])}</script></div></p>
			<script>
				function likeColor(){
					var classOfBody = $('#BODY').attr('class');
					if(classOfBody == "white"){document.body.className = 'red'; likeUpdate();}
					else{document.body.className = 'white'; likeCancel();}
				}
			</script>
		</div>
		
		
	</article>  
</body>
</html>