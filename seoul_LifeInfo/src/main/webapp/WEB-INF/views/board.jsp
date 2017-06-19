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
		<title>seoul life information</title>
</head>
	<script>
					var Name = "";
					var logoutButton = "<p><input type='button' class='logButton' value='log out' onclick='logout();'></p>"
					var ListsNum;
					var Lists;
					
					if(sessionStorage.getItem('name')){
						Name = sessionStorage.getItem('name');
					}else{
					}				
					
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
					
					
					function checkLists() {
						var data7 = "1";
						var data8 = "2";
				 		
						$.ajax({      // 보내는 데이터가 꼭 있어야 함 
									type: 'POST',
									url: "/info/checkLists",
									headers:{
										"Content-Type" : "application/json",
										"X-HTTP-Method-Override":"POST",
									},
									dataType:'text',
									data: JSON.stringify(
											{1 : data7, 2 : data8}		
										),
									success : function(result) {
										result = parseInt(result);
										ListsNum = result;
										
									},
									error : function(result){
										console.log(result);
										console.log("error!!!!");
									},
									async: false
						});	
					} checkLists();	
					
					
					function getLists() {
						var ListPageNum = "${ListPageNumber}";
						ListPageNum = parseInt(ListPageNum);
						var NumLists = ListsNum; 
				        
						$.ajax({      // 보내는 데이터가 꼭 있어야 함 
									type: 'POST',
									url: "/info/getLists",
									headers:{
										"Content-Type" : "application/json",
										"X-HTTP-Method-Override":"POST",
									},
									dataType:'json',
									data: JSON.stringify(
											{ListPageNum : ListPageNum, NumLists : NumLists}		
										),
									success : function(result) {
										console.log(result);
										Lists = result;
										
									},
									error : function(result){
										console.log(result);
										console.log("error!!!!");
									},
									async: false
									
						});	
					} getLists();
					
					
					
	</script>
<body >
	<header>
			<a href="/info" id='header'>Seoul Life Information</a>
	</header>
	<nav>
			   <ul>지하철</ul>
			   <ul>버스</ul>
			   <ul>날씨</ul>
			   <ul>미세먼지</ul>
			   <ul><a href="/info/main/board/1">게시판</a></ul>
	</nav>
	<article>
		<div id="logInBlock">			
			<script>
						if(Name == ""){  
								var	lines = "<p><input id='id' type='text' placeholder='ID'></p>";
									lines += "<p><input id='password' type='text' placeholder='PASSWORD'></p>";
									lines += "<input class='logButton' type='button' value='log in' onclick='log();'>";
									lines += "&nbsp; <a href='http://localhost:9999/info/join'>join us</a>";				
						   		document.write(lines);
				      	}
				        else{
				        		document.write("안녕하세요 "+ Name + "님" + logoutButton);
				       	} 
			</script>	
		</div>
			
		<h1 style="color: white;">자유게시판</h1>
		
		<ul id='boardList'>
			
			<script>
			var Numbers = [];
			for(var number in Lists) { Numbers.push(number); }
			Numbers.reverse();
			
			document.write("<div class='listBlock'>");
			document.write("<li style='color: black;'>Number<li>");
			for(var number in Numbers){
				document.write("<li><a id='Lists' href='/info/main/board/article/" +Lists[Numbers[number]]["number"] + "'>" + Numbers[number] + "</a></li>"); 
			}
			document.write("</div>");
			document.write("<div class='listBlock'>");
			document.write("<li style='color: black;'>Author<li>");
			for(var number in Numbers){
				document.write("<li><a id='Lists' href='/info/main/board/article/" +Lists[Numbers[number]]["number"] + "'>" + Lists[Numbers[number]]["author"] + "</a></li>"); 
			}
			document.write("</div>");
			
			document.write("<div class='listBlock'>");
			document.write("<li style='color: black;'>Title<li>");
			for(var number in Numbers){
				document.write("<li><a id='Lists' href='/info/main/board/article/" +Lists[Numbers[number]]["number"] + "'>" + Lists[Numbers[number]]["title"] + "</a></li>"); 
			}
			document.write("</div>");
			document.write("<div class='listBlock'>");
			document.write("<li style='color: black;'>Created<li>");
			for(var number in Numbers){
				document.write("<li><a id='Lists' href='/info/main/board/article/" +Lists[Numbers[number]]["number"] + "'>" + Lists[Numbers[number]]["created"] + "</a></li>"); 
			}
			document.write("</div>");
			
			document.write("<div class='listBlock'>");
			document.write("<li style='color: black;'>Likes<li>");
			for(var number in Numbers){
				document.write("<li><a id='Lists' href='/info/main/board/article/" +Lists[Numbers[number]]["number"] + "'>" + Lists[Numbers[number]]["likes"] + "</a></li>"); 
			}
			document.write("</div>");
			
			
			</script>
		</ul>
		
		<div id="ListsNum">
			<script>
			ListsNum2 = ListsNum/5;
			console.log(ListsNum2);
			for(var i=1; i<=(ListsNum2+1); i++){document.write("<ul><a href='/info/main/board/"+i+"'>"+i+"</a></ul>");}
			</script>
		</div>
		<a onclick="location.replace('/info/main/board/write')" style='float:left'>+ new</a>
	</article>  
</body>
</html>