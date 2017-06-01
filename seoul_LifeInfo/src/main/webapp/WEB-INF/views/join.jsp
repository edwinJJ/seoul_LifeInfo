<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <title>seoul life information</title>
  </head>
  <script>
 	function join() {
 		var data1 = $("#id").val();
 		var data2 = $("#password").val();
 		var data3 = $("#name").val();
 		var data4 = $("#birth").val();
 		var data5 = $("#phoneNumber").val();
 		var data6 = $("#address").val();
		$.ajax({
			type: 'POST',
			url: "join",
			headers:{
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override":"POST",
			},
			dataType:'JSON',
			data: JSON.stringify(
				{id : data1, password : data2, name : data3, birth : data4, 
					phoneNumber : data5, address : data6}		
			),
			success : function(result) {
			},
			error : function(result){
			}			
		});
		alert("회원가입이 완료되었습니다.");
		document.location.href="/info";
 	}
  </script>
  <body>
  <p>ID: <input id='id' name='id' type='text' placeholder='ID'></p>
  <p>password: <input id='password' name='password' type='text' placeholder='PASSWORD'></p>
  <p>닉네임: <input id='name'  type='text' placeholder='name'></p>
  <p>생년월일: <input id='birth'  type='text' placeholder='birth'></p>
  <p>전화번호: <input id='phoneNumber' type='text' placeholder='phoneNumber'></p>
  <p>집 주소: <input id='address' type='text' ></p>
  <input type='button' value='done' onclick="join();">
  
  </body>
</html>