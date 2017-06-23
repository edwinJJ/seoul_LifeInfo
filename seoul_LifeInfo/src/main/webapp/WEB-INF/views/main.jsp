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
					var Name = "";
					var logoutButton = "<p><a id='logoutButton' onclick='logout()'>log out</a></p>"
					var ListsNum;
					var Lists;
					var searchedLists;
					
					if(sessionStorage.getItem('name')){
						Name = sessionStorage.getItem('name');
					}else{
					}				

					var today = new Date();
					var mm = today.getMonth()+1; //January is 0!
						if(mm<10){mm="0"+mm;}
					var yyyy = today.getFullYear();
					var dd = today.getDate();
					
					function log() {
					 		var data1 = $("#id").val();
					 		var data2 = $("#password").val();
					 		
							$.ajax({
										type: 'POST',
										url: "logIn",
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
										location.replace("/info/1");
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
								$("#subwayData").html(result);
								var subwayLines = "";
								for(var i=0; i< $("#subwayData").children("realtimeStationArrival").children("row").length ; i++){
									subwayLines += "<div style='color: white;'>" + $("#subwayData").children("realtimeStationArrival").children("row").eq(i).children("trainLineNm").text() + "</div>" + "&nbsp;" + $("#subwayData").children("realtimeStationArrival").children("row").eq(i).children("arvlMsg2").text() + "&nbsp;" + $("#subwayData").children("realtimeStationArrival").children("row").eq(i).children("arvlMsg3").text()
									subwayLines += "<br/>"
								}	
									
								$("#subwayRealData").html(subwayLines);
							},
							error : function(result){
								console.log(result);
								console.log("error!!!!");
							}
						});	
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
								$("#weatherData").html(result);
								
								var weatherLines = "";
								for(var i=0; i< 7 ; i++){
									var DD = today.getDate();
										DD = DD + parseInt($("data").eq(i).children("day").text());
										weatherLines += "<div style='color: white;'>" +yyyy+"년 "+mm+"월 "+DD+"일 "+ $("data").eq(i).children("hour").text() +"시 "+ "</div>" + "&nbsp;" + $("data").eq(i).children("temp").text() + "℃" + "&nbsp;" + $("data").eq(i).children("wfKor").text()
										
								}	
									
								$("#realWeatherData").html(weatherLines);
							},
							error : function(result){
								console.log(result);
								console.log("error!!!!");
							}
					});	
				}getWeatherData();
				
				function getDustData() {
							var sh = document.getElementById("locationSelect"); 
							var location = sh.options[sh.selectedIndex].text;
							var date = $("#dustDate").val();
							$.ajax({
								type: 'POST',
								url: "/info/getDustData",
								headers:{
									"Content-Type" : "application/json",
									"X-HTTP-Method-Override":"POST",
								},
								dataType:'text',
								data: JSON.stringify(
									{location : location, date : date}		
								),
								success : function(result) {
									$("#dustData").html(result);
									
									var dustLines = "";
									for(var i=0; i< $("#dustData").children("DailyAverageAirQuality").children("row").length ; i++){
										var condition;
										var conditionColor;
										
										console.log(parseInt($("#dustData").children("DailyAverageAirQuality").children("row").eq(i).children("PM10").text()) + 10 );
										
										if(parseInt($("#dustData").children("DailyAverageAirQuality").children("row").eq(i).children("PM10").text()) < 30){condition='좋음'; conditionColor='blue';}
										else if((30 <= parseInt($("#dustData").children("DailyAverageAirQuality").children("row").eq(i).children("PM10").text())) && (parseInt($("#dustData").children("DailyAverageAirQuality").children("row").eq(i).children("PM10").text())< 80)){condition = '보통'; conditionColor='green';}
										else if((80 <= parseInt($("#dustData").children("DailyAverageAirQuality").children("row").eq(i).children("PM10").text())) && (parseInt($("#dustData").children("DailyAverageAirQuality").children("row").eq(i).children("PM10").text())< 150)){condition = '나쁨'; conditionColor='orange'}
										else if(150 <= parseInt($("#dustData").children("DailyAverageAirQuality").children("row").eq(i).children("PM10").text())){condition = '매우나쁨'; conditionColor='red';}
										
										dustLines += "<div style='color: white;'>" + $("#dustData").children("DailyAverageAirQuality").children("row").eq(i).children("MSRSTE_NM").text() +"<div style='color: "+conditionColor+"'>("+condition+")</div>"+ "</div>" + "<p>미세먼지 : " +$("#dustData").children("DailyAverageAirQuality").children("row").eq(i).children("PM10").text() + "</p>" + "<p>초미세먼지 : " + $("#dustData").children("DailyAverageAirQuality").children("row").eq(i).children("PM25").text() + "</p>"
										dustLines += "<br/>"
									}	
										
									$("#realDustData").html(dustLines);
								},
								error : function(result){
									console.log(result);
									console.log("error!!!!");
								}
							});	
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
				
				function search() {
					var data1 = $("#search").val();		
					var classOfBody = $('#BODY').attr('class');
			        
					$.ajax({      
								type: 'POST',
								url: "/info/search",
								headers:{
									"Content-Type" : "application/json",
									"X-HTTP-Method-Override":"POST",
								},
								dataType:'json',
								data: JSON.stringify(
										{searchData: data1, searchForWhat: classOfBody}		
									),
								success : function(result) {
									searchedLists = result;
									
									var searchedNumbers = [];
									for(var number in searchedLists) { searchedNumbers.push(number); }
									searchedNumbers.reverse();
									
									var htmlLines = "<ul id='boardList'>";
									 htmlLines += "<div class='listBlock'>";
									 htmlLines += "<li style='color: black;'>Number<li>";
									for(var number in searchedNumbers){
										 htmlLines += "<li><a id='Lists' href='/info/main/board/article/" +searchedLists[searchedNumbers[number]]["number"] + "'>" + searchedLists[searchedNumbers[number]]["number"] + "</a></li>";
									}
									 htmlLines += "</div>";
									
									 htmlLines += "<div class='listBlock'>";
									 htmlLines += "<li style='color: black;'>Author<li>";
									for(var number in searchedNumbers){
										 htmlLines += "<li><a id='Lists' href='/info/main/board/article/" +searchedLists[searchedNumbers[number]]["number"] + "'>" + searchedLists[searchedNumbers[number]]["author"] + "</a></li>";
									}
									 htmlLines += "</div>";
									
									 htmlLines += "<div class='listBlock'>";
									 htmlLines += "<li style='color: black;'>Title<li>";
									for(var number in searchedNumbers){
										 htmlLines += "<li><a id='Lists' href='/info/main/board/article/" +searchedLists[searchedNumbers[number]]["number"] + "'>" + searchedLists[searchedNumbers[number]]["title"] + "</a></li>";
									}
									 htmlLines += "</div>";
									
									 htmlLines += "<div class='listBlock'>";
									 htmlLines += "<li style='color: black;'>Created<li>";
									for(var number in searchedNumbers){
										 htmlLines += "<li><a id='Lists' href='/info/main/board/article/" +searchedLists[searchedNumbers[number]]["number"] + "'>" + searchedLists[searchedNumbers[number]]["to_char"] + "</a></li>";
									}
									 htmlLines += "</div>";
									
									 htmlLines += "<div class='listBlock'>";
									 htmlLines += "<li style='color: black;'>Likes<li>";
									for(var number in searchedNumbers){
										 htmlLines += "<li><a id='Lists' href='/info/main/board/article/" +searchedLists[searchedNumbers[number]]["number"] + "'>" + searchedLists[searchedNumbers[number]]["likes"] + "</a></li>";
									}
									 htmlLines += "</div>";
									 htmlLines += "</div>";
									
									
									$("#divForSearch").html(htmlLines);
									
								
								},
								error : function(result){
									console.log(result);
									console.log("error!!!!");
								},
								async: false
								
					});	
				} 
				
													
	</script>
<body class="title" id="BODY">
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
								var	lines = "<input class='logButton' type='button' value='log in' onclick='log();'>";
									lines += "<input id='id' type='text' placeholder='ID'><br/>";
									lines += "<input id='password' type='text' placeholder='PASSWORD'>";
									lines += "&nbsp; <a href='/info/join'>join us</a>";				
						   		document.write(lines);
					      	}
					        else{
					        		document.write("안녕하세요 "+ Name + "님" + logoutButton);
					       	}   
			</script>	
		</div>
		
		<div class='mainBlock' id='subwayBlock'>
			<h1 class='BlockTitle'>SUBWAY INFORMATION</h1>
			<h3 style='margin-left: 10px;'>역이름으로 검색</h3>
				<input type='text' id='stationName' placeholder='STATION NAME'>
				<input id='stationSearchButton' type='button' value='검색' onclick='getSubwayData()'>
				<div id='subwayData' style='display: none;'></div>
				<div id='subwayRealData'></div>
		</div>
		<div class='mainBlock' id='busBlock'>
			<h1 class='BlockTitle'>BUS INFORMATION</h1>
		</div>
		<div class='mainBlock' id='weatherBlock'>
			<h1 class='BlockTitle'>WEATHER INFORMATION</h1>
			<h3>경기도 성남시 분당구 정자2동</h3>
			<div id='weatherData' style='display: none;'></div>
			<div id='realWeatherData'></div>
		</div>
		<div class='mainBlock' id='dustBlock'>
					<h1 class='BlockTitle'>DUST INFORMATION</h1>
					<input type='text' id='dustDate' placeholder='DATE'> &nbsp;
					<div class='styled-select black rounded'>
						<select id='locationSelect' onChange="getDustData()">
								<option>강남<option>강남대로<option>강동구<option>강변북로<option>강북구<option>강서구<option>공항대로<option>관악구
								<option>광진구<option>구로구<option>금천구<option>노원구<option>도봉구<option>도산대로<option>동대문<option>동작구
								<option>동작대로<option>마포구<option>서대문구<option>서초구<option>성동구<option>성북구
						</select>
					</div>
					<div id='dustData' style='display: none;'></div>
					<div id='realDustData'></div>
					<script>function putDate(){$('#dustDate').val(yyyy.toString()+ mm.toString() +dd.toString())}putDate();</script>
		</div>
		<div class='mainBlock' id='boardBlock'>
					<h1 class='BlockTitle'>BOARD</h1>
					<div id='searchDiv'>
						<input type='radio' name='chooseSearch' value="name" onClick ="document.body.className = 'author';"> author
				 		<input type='radio' name='chooseSearch' value="title" checked onClick="document.body.className='title';"> title
						<input type='text' id='search' placeholder='search'><input type='button' value='검색' onclick='search()'>
					</div>
					<div id='divForSearch'>
								<ul id='boardList'>
									<script>
									var Numbers = [];
									for(var number in Lists) { Numbers.push(number); }
									Numbers.reverse();
									
									
									document.write("<div class='listBlock'>");
									document.write("<li style='color: black;'>Number<li>");
									
									for(var number in Numbers){
										document.write("<li><a name='"+Numbers[number]+"' id='Lists' href='/info/main/board/article/" +Lists[Numbers[number]]["number"] + "'>" + Numbers[number] + "</a></li>"); 
									}
									document.write("</div>");
									document.write("<div class='listBlock'>");
									document.write("<li style='color: black;'>Author<li>");
									for(var number in Numbers){
										document.write("<li><a name='"+Numbers[number]+"' id='Lists' href='/info/main/board/article/" +Lists[Numbers[number]]["number"] + "'>" + Lists[Numbers[number]]["author"] + "</a></li>"); 
									}
									document.write("</div>");
									
									document.write("<div class='listBlock'>");
									document.write("<li style='color: black;'>Title<li>");
									for(var number in Numbers){
										document.write("<li><a name='"+Numbers[number]+"' id='Lists' href='/info/main/board/article/" +Lists[Numbers[number]]["number"] + "'>" + Lists[Numbers[number]]["title"] + "</a></li>"); 
									}
									document.write("</div>");
									document.write("<div class='listBlock'>");
									document.write("<li style='color: black;'>Created<li>");
									for(var number in Numbers){
										document.write("<li><a name='"+Numbers[number]+"' id='Lists' href='/info/main/board/article/" +Lists[Numbers[number]]["number"] + "'>" + Lists[Numbers[number]]["to_char"] + "</a></li>"); 
									}
									document.write("</div>");
									
									document.write("<div class='listBlock'>");
									document.write("<li style='color: black;'>Likes<li>");
									for(var number in Numbers){
										if(Lists[Numbers[number]]["likes"]){
											document.write("<li><a name='"+Numbers[number]+"' id='Lists' href='/info/main/board/article/" +Lists[Numbers[number]]["number"] + "'>" + Lists[Numbers[number]]["likes"] + "</a></li>"); 
										}else{
											document.write("<li>0</li>");
										}						
									}
									document.write("</div>");
									
									/* -- 그 목록 전체가 검은색으로 되도록 하고싶음 
									$("a[name="+Numbers[number]+"]").hover(
											  function() {
											    $("a[name="+Numbers[number]+"]").addClass( "hoverIn" );
											  }, function() {
											    $("a[name="+Numbers[number]+"]").removeClass( "hoverIn" );
											  }
									);
									*/	
									</script>
								</ul>
								
								<div id="ListsNum">
									<script>
									ListsNum2 = ListsNum/10;
									for(var i=1; i<(ListsNum2+1); i++){document.write("<ul><a href='/info/"+i+"' style='color: black;'>"+i+"</a></ul>");}
									</script>
								</div>
								<a href='/info/logError' style='float:left; color:black;'>+ new</a>
					</div>
		</div>
	</article>  
</body>
</html>
