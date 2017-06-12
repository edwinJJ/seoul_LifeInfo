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
					var logoutButton = "<p><input type='button' value='log out' onclick='logout();' style='background-color: white; color:skyblue;'></p>"
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
<body style="background-color: skyblue;">
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
		
		<ul style="list-style: none; font-size: 23px;padding-left: 200px; color: aliceblue;">
		<li style="color: black;">Number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;author&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;created&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;title&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;like</li>
		<li><input id="writeButton" type="button" onclick="location.replace('/info/main/board/write')" value="+"></li>
		<script>
		//Lists.sort(function(a,b){return (a.value < b.value)? -1:(a.value>b.value)? 1:0;}); // 정렬 반대로
		for(var objVarName in Lists) { document.write("<li><a id='Lists' href='/info/main/board/article/" + objVarName + "'>&nbsp;&nbsp;&nbsp;&nbsp;" + objVarName + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"); for(var cul in Lists[objVarName]){document.write( Lists[objVarName][cul] + "&nbsp;&nbsp;&nbsp;&nbsp;");} document.write("</a></li>");}
		</script>
		</ul>
		
		<div id="ListsNum">
			<script>
			ListsNum2 = ListsNum/5;
			console.log(ListsNum2);
			for(var i=1; i<=(ListsNum2+1); i++){document.write("<ul><a href='/info/main/board/"+i+"'>"+i+"</a></ul>");}
			</script>
		</div>
		
	</article>  
</body>
</html>