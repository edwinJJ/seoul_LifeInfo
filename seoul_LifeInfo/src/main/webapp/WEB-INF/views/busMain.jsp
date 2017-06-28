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
												location.replace("/info/main/bus");
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
										location.replace("/info/main/bus");
					}
					
					function getBusData() {
						$.ajax({
							type: 'POST',
							url: "/info/getBusData",
							headers:{
								"Content-Type" : "application/json",
								"X-HTTP-Method-Override":"POST",
							},
							dataType:'text',
							data: JSON.stringify(
								{stationName : "stationName"}		
							),
							success : function(result) {
								$("#busData").html(result);
								var busLines = "";
								busLines += "<h2>정류소 ID : "+$("msgBody").children("busArrivalList").eq(0).children("stationId").text()+"</h2>";   
								for(var i=0; i< $("busArrivalList").length ; i++){
									busLines += "</br>"+"<div style='color: white'>버스 노선 ID : "+ $("msgBody").children("busArrivalList").eq(i).children("routeId").text()+"</div>" // 노선 id
									
									if(($("msgBody").children("busArrivalList").eq(i).children("locationNo1").text()) == 1){
										busLines += "</br><span style='color: red'> 전 정류장</span>"
									}else{
										busLines += "</br><span style='color: red'>" + $("msgBody").children("busArrivalList").eq(i).children("locationNo1").text() + "정류장 전</span>"; 
									}
									busLines += "(" + $("msgBody").children("busArrivalList").eq(i).children("predictTime1").text() + "분 후 도착예정" + ")";  
									if(parseInt($("msgBody").children("busArrivalList").eq(i).children("lowPlate1").text())==1){
										busLines += "</br>" + "<span style='color: blue;'>저상버스</span>";
									}
									if(parseInt($("msgBody").children("busArrivalList").eq(i).children("remainSeatCnt1" ).text())==-1){
										busLines += "<br/> 빈자리 수 : 0"
									}else{
										busLines += "</br> 빈자리 수 : " + $("msgBody").children("busArrivalList").eq(i).children("remainSeatCnt1" ).text();
									}
									if(($("msgBody").children("busArrivalList").eq(i).children("locationNo2").text()) == 1){
										busLines += "</br><span style='color: red'> 전 정류장</span>"
									}else{
										busLines += "</br><span style='color: red'>" + $("msgBody").children("busArrivalList").eq(i).children("locationNo2").text() + "정류장 전</span>"; 
									}
									busLines += "(" + $("msgBody").children("busArrivalList").eq(i).children("predictTime2").text() + "분 후 도착예정" + ")"; 
									if(parseInt($("msgBody").children("busArrivalList").eq(i).children("lowPlate2").text())==1){
										busLines += "</br>" +"<span style='color: blue;'>저상버스</span>";
									}
									if(parseInt($("msgBody").children("busArrivalList").eq(i).children("remainSeatCnt2" ).text())==-1){
										busLines += "<br/> 빈자리 수 : 0"
									}else{
										busLines += "</br> 빈자리 수 : " + $("msgBody").children("busArrivalList").eq(i).children("remainSeatCnt2" ).text();
									}
									if($("msgBody").children("busArrivalList").eq(i).children("flag").text() == "STOP"){
										busLines += "<br/><span style='color: red'>운행종료</span>"
									}else if($("msgBody").children("busArrivalList").eq(i).children("flag").text() == "WAIT"){
										busLines += "<br/>회차지 대기"
									}
									busLines += "<br/>"
								}	
									
								$("#realBusData").html(busLines);
								
							},
							error : function(result){
								console.log(result);
								console.log("error!!!!");
							}
					});	
				} getBusData();
				
				function onKeyDownLog()
				{
				     if(event.keyCode == 13)
				     {
				          log();
				     }
				}
				
				function getBusStationData() {
			 		
					$.ajax({
								type: 'POST',
								url: "/info/getBusStationData",
								headers:{
									"Content-Type" : "application/json",
									"X-HTTP-Method-Override":"POST",
								},
								dataType:'text',
								data: JSON.stringify(
									{id : "haha"}		
								),
								success : function(result) {
								},
								error : function(result){
								}
					});	
			} getBusStationData();
			
													
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
		<h1 style='font-family: fantasy;'>BUS INFORMATION</h1>
		<div id='busData' style='display: none;'></div>
		<div id='realBusData'></div>
		
	</article>  
</body>
</html>
