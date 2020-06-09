<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function emailCheck(){
		var f = document.myForm;
		
		var clen = f.emailSel.options.length;
		var cvalue = f.emailSel.selectedIndex;
		
		f.email2.value = "";
		if(cvalue==(clen-1)){
			
			f.email2.readOnly = false;
			
		}else{
			
			f.email2.value = f.emailSel.options[cvalue].value;
			f.email2.readOnly = true;
		}
	}

</script>


</head>
<body>

<form action="" name="myForm">
email 주소
<input type="text" name="email1"/>
@
<input type="text" name="emanil2" readonly="readonly"/>

<select name="emailSel" onchange="emailCheck();">
<option value="">선택</option>
<option value="">직접 입력</option>
<option value="naver.com">네이버</option>
<option value="daum.net">다음</option>
<option value="yahoo.com">야후</option>
<option value="nate.com">네이트</option>


</select>


</form>
</body>
</html>