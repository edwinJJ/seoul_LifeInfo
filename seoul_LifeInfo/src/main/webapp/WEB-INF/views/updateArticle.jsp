<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
		<spring:url value="/resources/css/board.css" var="boardCSS" />
		<link href="${boardCSS}" rel="stylesheet" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery.form.js"></script>
		<title>seoul life information</title>
</head>
	<script>
					var Name = "";
					var logoutButton = "<p><a id='logoutButton' onclick='logout()'>log out</a></p>"
					var Article;
					
					
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
					
					
					function update() {
						
				 		var data1 = $("#title").text();
				 		var data2 = $("#description").text();
				 		var articleNumber = "${articleNumber}";
						 articleNumber = parseInt(articleNumber);
				 		
						$.ajax({
							type: 'POST',
							url: "/info/main/board/updateArticle",
							headers:{
								"Content-Type" : "application/json",
								"X-HTTP-Method-Override":"POST",
							},
							dataType: 'text',
							data: JSON.stringify(
								{title: data1, description: data2, articleNumber: articleNumber}		
							),
							success : function(result) {
								if(result == "true") {
									alert("게시글 수정이 완료되었습니다.");
									location.replace("/info/main/board/article/"+articleNumber);
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
					
					function getArticleForUpdate(){
							var articleNumber = "${articleNumber}";
								 articleNumber = parseInt(articleNumber);
					        
							$.ajax({     
										type: 'POST',
										url: "/info/getArticleForUpdate",
										headers:{
											"Content-Type" : "application/json",
											"X-HTTP-Method-Override":"POST",
										},
										dataType:'json',
										data: JSON.stringify(
												{articleNumber : articleNumber}		
											),
										success : function(result) {
											Article = result;
										},
										error : function(result){
											console.log(result);
											console.log("error!!!!");
										},
										async: false
										
							});	
					}getArticleForUpdate();
													
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
		<h1 style="font-family:fantasy">BOARD</h1>
		<p>작성자:<script>document.write(Name);</script></p>
		<p>TITLE <div class="editable" id='title' style="width: 1000px; height: 20px;border: 1px solid #ccc; padding: 5px; background-color: white;"></div></p>
		<p>DESCRIPTION <div class="editable" id='description' style="width: 1000px; height: 1000px;border: 1px solid #ccc; padding: 5px; background-color: white;"></div></p>
		<p><input type='button' value="작성" onclick='update();'></p>
		
		<script>
			$('.editable').each(function(){
			    this.contentEditable = true;
			});
			document.getElementById("title").innerText = Article["title"];
			document.getElementById("description").innerText = Article["description"];
		</script>
	</article>  
</body>
</html>
