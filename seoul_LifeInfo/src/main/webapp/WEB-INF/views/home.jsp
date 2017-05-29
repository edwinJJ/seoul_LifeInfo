<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<script>
function test() {
	var data = $("#data").html();
	$.ajax({
		type: 'POST',
		url: "test",
		headers:{
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override":"POST",
		},
		dataType:'JSON',
		data: data,
		success : function(result) {
		},
		error : function(result){
		}
	});
}
</script>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

<button onclick="test();">submit</button>
<div id="data">data_100</div>
</body>
</html>
