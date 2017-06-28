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
					var logoutButton = "<p><a id='logoutButton' onclick='logout()'>log out</a></p>"
					var ListsNum;
					var Lists;
					var searchedLists;
					
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
												location.replace("/info/main/board/1");
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
										location.replace("/info/main/board/1");
					}
					
					
					function checkLists() {
						var data7 = "1";
						var data8 = "2";
				 		
						$.ajax({      
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
				        
						$.ajax({     
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
											if(searchedLists[searchedNumbers[number]]["likes"]){
												htmlLines += "<li><a id='Lists' href='/info/main/board/article/" +searchedLists[searchedNumbers[number]]["number"] + "'>" + searchedLists[searchedNumbers[number]]["likes"] + "</a></li>"; 
											}else{
												htmlLines += "<li>0</li>";
											}		
											 
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
					
					function onKeyDownBoardSearch()
					{
					     if(event.keyCode == 13)
					     {
					          search();
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
<body class="title" id="BODY">
	<header>
			<a href="/info" id='header'>Seoul Life Information</a>
	</header>
	<nav>
			   <ul><a href='/info/main/subway'>지하철</a></ul>
			   <ul><a href='/info/main/bus'>버스</a></ul>
			   <ul><a href='/info/main/weather'>날씨</a></ul>
			   <ul><a href='/info/main/dust'>미세먼지</a></ul>
			   <ul><a href="/info/main/board/1">게시판</a></ul>
	</nav>
	<article>
		<div id="logInBlock">			
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
			
		<h1 style='font-family: fantasy;'>BOARD</h1>
		
		
		<div id='searchDiv'>
			<input type='radio' name='chooseSearch' value="name" onClick ="document.body.className = 'author';"> author
	 		<input type='radio' name='chooseSearch' value="title" checked onClick="document.body.className='title';"> title
			<input type='text' id='search' placeholder='search' onkeydown='onKeyDownBoardSearch();'><input type='button' value='검색' onclick='search()'>
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
						
						</script>
					</ul>
					
					<div id="ListsNum">
						<script>
						ListsNum2 = ListsNum/10;
						for(var i=1; i<(ListsNum2+1); i++){document.write("<ul><a href='/info/main/board/"+i+"' style='color: black;'>"+i+"</a></ul>");}
						</script>
					</div>
					<a href='/info/main/board/write' style='float:left; color:black;'>+ new</a>
		</div>
		<script>
		var clientWidth = document.body.clientWidth;
		$("#boardList").css("font-size", (clientWidth * 20 / 1249)+"px");
		$("#searchDiv").css("margin-left", (clientWidth * 710 / 1249)+"px");
		</script>
	</article>  
</body>
</html>
