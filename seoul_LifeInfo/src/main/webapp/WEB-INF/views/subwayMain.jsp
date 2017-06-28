<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
		<spring:url value="/resources/css/subwayMain.css" var="subwayMainCSS" />
		<link href="${subwayMainCSS}" rel="stylesheet" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<title>seoul life information</title>
</head>
	<script>
					var Name = "";
					var logoutButton = "<p><a id='logoutButton' onclick='logout()'>log out</a></p>"
					
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
											if(result==null || result==""){
												location.replace("/info/logError"); 
											}else{
												sessionStorage.setItem('name', result);
												location.replace("/info/main/subway");
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
										location.replace("/info/main/subway");
					}
					
					function getSubwayData() {
						var stationName = $("#stationName").val();
						$.ajax({
							type: 'POST',
							url: "/info/getSubwayData",
							headers:{
								"Content-Type" : "application/json",
								"X-HTTP-Method-Override":"POST",
							},
							dataType:'text',
							data: JSON.stringify(
								{stationName : stationName}		
							),
							success : function(result) {
								$("#data").html(result);
								
								var lines = "";
								for(var i=0; i< $("row").length ; i++){
									lines += "<div	class='trainLine'>" + $("row").eq(i).children("trainLineNm").text() + "</div>" + "&nbsp;" + "<div class='subwayDescription'>" +$("row").eq(i).children("arvlMsg2").text() + "&nbsp;" + "</div>" +"<br/>"+ "<div class='openDoor'>"+ "내리실문-" + $("row").eq(i).children("subwayHeading").text() + "</div>"
									lines += "<br/>"
								}	
									
								$("#realData").html(lines);
							},
							error : function(result){
								console.log(result);
								console.log("error!!!!");
							}
				});	
					}
					
					
					function onKeyDownStation()
					{
					     if(event.keyCode == 13)
					     {
					          getSubwayData();
					     }
					}
					
					function onKeyDownLog()
					{
					     if(event.keyCode == 13)
					     {
					          log();
					     }
					}
													
	</script>
<body >
	<header>
			<a href="/info" style="color: white;
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
								var	lines = "<input class='logButton' type='button' value='log in' onclick='log();'>";
								lines += "<input id='id' type='text' placeholder='ID'><br/>";
								lines += "<input id='password' type='password' placeholder='PASSWORD' onKeyDown='onKeyDownLog();'>";
								lines += "&nbsp; <a href='/info/join'>join us</a>";				
					   		document.write(lines);
				      	}
				        else{
				        		document.write("안녕하세요 "+ Name + "님" + logoutButton);
				       	}   
			</script>	
		</div>
		<h1 style='font-family: fantasy;'>SUBWAY INFORMATION</h1>
		<div id='subwaySearchDiv'>
			<h3 style='color: white;'>역이름으로 검색</h3>
				<input type='text' id='stationName' placeholder='STATION NAME' onkeydown='onKeyDownStation();'>
				<input id='searchButton' type='button' value='검색' onclick='getSubwayData()'>
				<div id='data' style='display: none;'></div>
				<div id='realData'></div>
		</div>
	</article>  
</body>
</html>
