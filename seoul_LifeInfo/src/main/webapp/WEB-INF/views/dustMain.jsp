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
									
									var lines = "";
									for(var i=0; i< $("row").length ; i++){
										var condition;
										var conditionColor;
										
										console.log(parseInt($("row").eq(i).children("PM10").text()) + 10 );
										
										if(parseInt($("row").eq(i).children("PM10").text()) < 30){condition='좋음'; conditionColor='blue';}
										else if((30 <= parseInt($("row").eq(i).children("PM10").text())) && (parseInt($("row").eq(i).children("PM10").text())< 80)){condition = '보통'; conditionColor='green';}
										else if((80 <= parseInt($("row").eq(i).children("PM10").text())) && (parseInt($("row").eq(i).children("PM10").text())< 150)){condition = '나쁨'; conditionColor='orange'}
										else if(150 <= parseInt($("row").eq(i).children("PM10").text())){condition = '매우나쁨'; conditionColor='red';}
										
										lines += "<div style='color: white;'>" + $("row").eq(i).children("MSRSTE_NM").text() +"<div style='color: "+conditionColor+"'>("+condition+")</div>"+ "</div>" + "&nbsp;" + "<p>미세먼지 : " +$("row").eq(i).children("PM10").text() + "</p>" + "<p>초미세먼지 : " + $("row").eq(i).children("PM25").text() + "</p>"
										lines += "<br/>"
									}	
										
									$("#realDustData").html(lines);
								},
								error : function(result){
									console.log(result);
									console.log("error!!!!");
								}
							});	
					}
													
	</script>
<body >
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
		<h1 style='font-family: fantasy;'>DUST INFORMATION</h1>
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
	</article>  
</body>
</html>
