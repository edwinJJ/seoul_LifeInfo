<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
		<spring:url value="/resources/css/weatherMain.css" var="weatherMainCSS" />
		<link href="${weatherMainCSS}" rel="stylesheet" />
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
												location.replace("/info/main/weather");
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
										location.replace("/info/main/weather");
					}
					
					function getWeatherData() {
						$.ajax({
							type: 'POST',
							url: "/info/getWeatherData",
							headers:{
								"Content-Type" : "application/json",
								"X-HTTP-Method-Override":"POST",
							},
							dataType:'text',
							data: JSON.stringify(
								{weather : "weather"}		
							),
							success : function(result) {
								$("#weather").html(result);
								
								var today = new Date();
								
								var mm = today.getMonth()+1; //January is 0!
								var yyyy = today.getFullYear()
								
								var weatherLines = "<h1>"+$("category").text()+"</h1>";
								for(var i=0; i< $("data").length ; i++){
										var dd = today.getDate();
										dd = dd + parseInt($("data").eq(i).children("day").text());
										weatherLines += "<div>" 
										weatherLines += "<span class='weatherDesc'>"
										weatherLines += "<span style='color: white;'>" +yyyy+"년 "+mm+"월 "+dd+"일 "
										weatherLines += $("data").eq(i).children("hour").text() +"시 "+ "</span>" + "&nbsp;" 
										weatherLines += $("data").eq(i).children("temp").text() +"℃"+ "&nbsp;" 
										weatherLines += $("data").eq(i).children("wfKor").text() 
										weatherLines += "</span>"
										weatherLines += "&nbsp;"	
								
											if($("data").eq(i).children("wfKor").text() == "구름 많음"){
												weatherLines += "<img class='weatherImg' src='/info/resources/images/구름 많음.jpg'>"
											}
											if($("data").eq(i).children("wfKor").text() == "흐림"){
												weatherLines += "<img class='weatherImg' src='/info/resources/images/흐림.jpg'>"
											}
											if($("data").eq(i).children("wfKor").text() == "비"){
												weatherLines += "<img class='weatherImg' src='/info/resources/images/비.jpg'>"
											}
											if($("data").eq(i).children("wfKor").text() == "맑음"){
												weatherLines += "<img class='weatherImg' src='/info/resources/images/맑음.jpg'>"
											}
											if($("data").eq(i).children("wfKor").text() == "구름 조금"){
												weatherLines += "<img class='weatherImg' src='/info/resources/images/구름 조금.jpg'>"
											}
											if($("data").eq(i).children("wfKor").text() == "눈"){
												weatherLines += "<img class='weatherImg' src='/info/resources/images/눈.jpg'>"
											}
											weatherLines += "</div>"
								}	
								
								$("#realWeather").html(weatherLines);
							},
							error : function(result){
								console.log(result);
								console.log("error!!!!");
							}
					});	
				}getWeatherData();
				
				
				function onKeyDownLog()
				{
				     if(event.keyCode == 13)
				     {
				          log();
				     }
				}
													
	</script>
<body>
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
		<h1 style='font-family: fantasy;'>WEATHER INFORMATION</h1>
	
		
		<div id='weather' style='display: none;'></div>
		<div id='realWeather'></div>
	</article>  
</body>
</html>
