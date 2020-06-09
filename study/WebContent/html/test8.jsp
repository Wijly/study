<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function textCopy(){
		
		var cvalue;
		cvalue = window.document.myForm.check1.cheked;
		
		if(cvalue){
			document.myForm.client2.value = document.myForm.client1.value
		}else{
			document.myForm.clint2.value= "" ;
		}
	}
	

</script>
</head>
<body>
<form action="" name="myForm">
	주문 고객 정보 - 주소 <input type="text" size="40" name="client1"/>
	<input type="checkbox" name="check1" onclick="textCopy();"/> 배송장소가 위와 동일 <br/>
	배송 장소 정보 - 주소 <input type="text" size="40" name="client2"/><br/>

</form>
</body>
</html>