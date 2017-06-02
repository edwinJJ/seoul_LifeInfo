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
	function test() {
		$.ajax({
			type: 'POST',
			url: "test",
			headers:{
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override":"POST",
			},
			dataType:'text',
			data: "testData",
			success : function(result) {
				console.log(result);
				$("#showData").html(result);
			},
			error : function(result){
				console.log(result);
			}			
		});
	}
</script>
<body>
	<a href="/info/test/abc"><button>click</button></a>
	<div id="showData">
		<span>abc</span>this is ${ testData }  aa</div>
	<div onclick="test();"><button>click2</button></div>
</body>
</html>









