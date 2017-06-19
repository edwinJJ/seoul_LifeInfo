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
					var logoutButton = "<p><input type='button' class='logButton' value='log out' onclick='logout();'></p>"
					var Article;
					var articleNum;
					var Replies;
					
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
						
						if(sessionStorage.getItem('name')){
							var articleNumber = "${articleNumber}";
							var articleNum = parseInt(articleNumber);
							$.ajax({     
										type: 'POST',
										url: "/info/likeUpdate",
										headers:{
											"Content-Type" : "application/json",
											"X-HTTP-Method-Override":"POST",
										},
										dataType: 'text',
										data: JSON.stringify(
												{name: Name, articleNum : articleNum}		
											),
										success : function(result) {
											console.log(result);
											if(result == "true") {
												document.body.className = 'red';
												location.replace("/info/main/board/article/"+articleNum);
											} else {
												alert("좋아요 실패");
											}
										},
										error : function(result){
											console.log(result);
											console.log("error!!!!");
										},
							});	
							
						}else{
							alert("로그인을 해야합니다.");
							location.replace('/info/logError');
						}		
					} 
					
					function likeCancel(){
						var articleNumber = "${articleNumber}";
						articleNum = parseInt(articleNumber);
						$.ajax({     
									type: 'POST',
									url: "/info/likeCancel",
									headers:{
										"Content-Type" : "application/json",
										"X-HTTP-Method-Override":"POST",
									},
									dataType: 'text',
									data: JSON.stringify(
											{name: Name, articleNum : articleNum}		
										),
									success : function(result) {
										console.log(result);
										if(result == "true") {
											document.body.className = 'white';
											location.replace("/info/main/board/article/"+articleNum);
										} else {
											alert("좋아요 취소 실패");
										}
									},
									error : function(result){
										console.log(result);
										console.log("error!!!!");
									},
						});	
					}
					
					function setReply() { 
						
											if(sessionStorage.getItem('name')){
												var replyDesc = $("#replyDesc").val(); 
												var articleNumber = "${articleNumber}";
												var articleNum = parseInt(articleNumber);
												
												$.ajax({ 
													type: 'POST', 
													url: "/info/setReply", 
													headers:{ "Content-Type" : "application/json", "X-HTTP-Method-Override":"POST", }, 
													dataType: 'text', 
													data: JSON.stringify( 
															{name : Name , articleNum : articleNum, replyDesc: replyDesc} 
															), 
													success : function(result) { 
																	console.log(result); 
																	if(result == "true") { 
																		location.replace("/info/main/board/article/"+articleNum);
																	} else { 
																		alert("댓글 등록 실패"); 
																	} 
															  }, 
													 error : function(result){ 
																console.log(result); 
																console.log("error!!!!"); 
															 }, 
												}); 
											}else{
												alert("로그인을 해야합니다.");
												location.replace('/info/logError');
											}		
					}
					
					function getReplies() {
						var articleNumber = "${articleNumber}";
							 articleNumber = parseInt(articleNumber);
				        
						$.ajax({     
									type: 'POST',
									url: "/info/getReplies",
									headers:{ "Content-Type" : "application/json", "X-HTTP-Method-Override":"POST", }, 
									dataType: 'json', 
									data: JSON.stringify(
											{articleNumber : articleNumber}		
										),
									success : function(result) {
										Replies = result;
										console.log(Replies);
										console.log("성공");
									},
									error : function(result){
										console.log(result);
										console.log("error!!!!");
									},
									async : false
									
						});	
					} getReplies();
					
					
				function viewReplyToReply(ReplyNumber, HowManyHaveSuper) {
					var Margin = HowManyHaveSuper*40;
					$("#setReplyReply" + ReplyNumber).html("<div style='margin-left: "+Margin+"px;'><textarea class='replyToReplyDesc' id='replyInReplyDesc"+ReplyNumber+"' placeholder='Comment..'></textarea><input class='replyButton' type='button' value='작성' onclick='setReplyToReply("+ReplyNumber+")'></div>");
					var replyLines = "";
					console.log(ReplyNumber);
					console.log(HowManyHaveSuper);
					$.each(Replies, function(i, v){
						if ((parseInt(v.location[HowManyHaveSuper])==ReplyNumber) && (parseInt(v.location.length)==HowManyHaveSuper+1)){
							var SendHowManyHaveSuper = HowManyHaveSuper+1;
							replyLines += "<div style='margin-left: "+Margin+"px;border: 2px white solid;'><div style='color: white;'>" +v.name+ "</div>" + "&nbsp" + v.description  + "<br/>" + "<a style='float: right;' onclick='deleteReply()'>X</a><a id='replyToReply"+parseInt(v.number)+"' class='view' onclick='viewOrFoldReplyToReply("+parseInt(v.number)+", "+SendHowManyHaveSuper+")' style='font-size: 12px;'>대화 보기/접기</a>";
							if(v.name == Name){
							}	
							replyLines += "</div><div id='setReplyReply"+parseInt(v.number)+"'></div><div id='replyReplies"+parseInt(v.number)+"'></div>";
						}
					});
					
					$("#replyReplies" + ReplyNumber).html(replyLines);
				}	
				
				function foldReplyToReply(ReplyNumber){
					console.log("haha");
					$("#setReplyReply" + ReplyNumber).html("<div></div>");
					$("#replyReplies" + ReplyNumber).html("<div></div>");	
				}
				
				function setReplyToReply(ReplyNumber){
						if(sessionStorage.getItem('name')){
							
								var replyInReplyDesc = $("#replyInReplyDesc"+ReplyNumber).val(); 
									var articleNumber = "${articleNumber}";
								var articleNum = parseInt(articleNumber);
								var replyNum = parseInt(ReplyNumber);
								
								$.ajax({ 
									type: 'POST', 
									url: "/info/setReplyToReply", 
									headers:{ "Content-Type" : "application/json", "X-HTTP-Method-Override":"POST", }, 
									dataType: 'text', 
									data: JSON.stringify( 
											{name : Name , replyInReplyDesc: replyInReplyDesc, replyNum: replyNum} 
											), 
									success : function(result) { 
													console.log(result); 
													if(result == "true") { 
														location.replace("/info/main/board/article/"+articleNum);
													} else { 
														alert("댓글 등록 실패"); 
													} 
											  }, 
									 error : function(result){ 
												console.log(result); 
												console.log("error!!!!"); 
											 }, 
								}); 
							
						}else{
							alert("로그인을 해야합니다.");
							location.replace("/info/logError");
						}		
				}
				
				function viewOrFoldReplyToReply(ReplyNumber, HowManyHaveSuper){
					var classOfReplyToReply = $('#replyToReply'+ReplyNumber).attr('class');
					console.log(classOfReplyToReply);
					if(classOfReplyToReply == 'view'){
						viewReplyToReply(ReplyNumber, HowManyHaveSuper);
						$('#replyToReply'+ReplyNumber).attr('class','fold');
					}else if(classOfReplyToReply=='fold'){
						foldReplyToReply(ReplyNumber);
						$('#replyToReply'+ReplyNumber).attr('class','view');
					}
				}
				
				function deleteArticle(){
					var articleNumber = "${articleNumber}";
					 articleNumber = parseInt(articleNumber);
					
					$.ajax({     
						type: 'POST',
						url: "/info/deleteArticle",
						headers:{
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override":"POST",
						},
						dataType: 'text',
						data: JSON.stringify(
								{articleNumber : articleNumber}		
							),
						success : function(result) {
							console.log(result);
							if(result == "true") {
								alert("게시글이 삭제되었습니다.");
								location.replace("/info/main/board/1");
							} else {
								alert("게시글 삭제 실패");
							}
						},
						error : function(result){
							console.log(result);
							console.log("error!!!!");
						},
					});	
				}
					
				
				function deleteReply(replyNumber){
					var articleNumber = "${articleNumber}";
					 articleNumber = parseInt(articleNumber);
					
					$.ajax({     
						type: 'POST',
						url: "/info/deleteReply",
						headers:{
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override":"POST",
						},
						dataType: 'text',
						data: JSON.stringify(
								{replyNumber : replyNumber}		
							),
						success : function(result) {
							console.log(result);
							if(result == "true") {
								alert("댓글이 삭제되었습니다.");
								location.replace("/info/main/board/article/"+articleNumber);
							} else {
								alert("댓글 삭제 실패");
							}
						},
						error : function(result){
							console.log(result);
							console.log("error!!!!");
						},
					});	
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
		<div id="logIn">			
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
			<div id='articleDescription'>
				<p><script>document.write(Article["description"])</script></p>
			</div>			
			<p>
				<div>
					<script>
					
						if(Article["author"] == Name){
							document.write("<a onclick='deleteArticle()'>게시글 삭제</a>")
							document.write("<br/><a href='/info/main/board/updateArticle/"+Article['number']+"'>게시글 수정</a>")
						}
					</script>
				</div>
			</p>
			<p><div class="hearty" onclick="like()">
					<script>
						if(Article["likes"]){
							var ArticleLikes = Article["likes"];
							if(ArticleLikes.indexOf(Name) == -1){}
							else{document.body.className = 'red'}
							
							document.write(Article["likes"].length + "&nbsp;"); 
							for(var i=0; i<Article["likes"].length; i++){
								document.write(Article["likes"][i]); 
								if(i<Article["likes"].length-1){
									document.write(",&nbsp;");
								}
							} 
						}
					</script>
				</div>
			</p>
			<script>
				function like(){
					var classOfBody = $('#BODY').attr('class');
					if(classOfBody == "white"){ likeUpdate();}
					else{ likeCancel();}
				}
			</script>
		</div>
		<div>
			<textarea class='replyDesc' id='replyDesc' placeholder="Comment.."></textarea>
			<button id='replyButton' onclick='setReply()'>작성</button>
		</div>
		<div id="replyLists">
			<script>
			var articleNumber = "${articleNumber}";
			 articleNumber = parseInt(articleNumber);
			 
			$.each(Replies, function(i, v){
				if (v.location[1]==null){
					document.write("<div id='reply'>" + "<div style='color: white;'>" +v.name+ "</div>" + "&nbsp" + v.description  + "<br/>" + "<a id='replyToReply"+parseInt(v.number)+"' class='view' onclick='viewOrFoldReplyToReply("+parseInt(v.number)+", "+1+")' style='font-size: 12px;'>대화 보기/접기</a>");
					if(v.name == Name){
						document.write("<a style='float: right;' onclick='deleteReply("+parseInt(v.number)+")'>X</a>");
					}
					document.write("</div>" + "<div id='setReplyReply"+parseInt(v.number)+"'></div><div id='replyReplies"+parseInt(v.number)+"'></div>");
				}
			});
			
			</script>
		</div>
	</article>  
</body>
</html>