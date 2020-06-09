<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function checkAll(){
		var clen = document.myForm("sul").length;	// 갯수 가져오기
		
		for(var i=0; i<clen; i++){
			document.myForm["sul"][i].checked = true;		//i 번쨰의 체크속성을 트루로 변환
		}
	}
	
	function checkDel(){
		var clen = document.myForm("sul").length;	// 갯수 가져오기
		
		for(var i=0; i<clen; i++){
			document.myForm["sul"][i].checked = false;		//i 번쨰의 체크속성을 false로 변환
		}
	}
	
	function bestsul(){
		var clen = document.myForm1.sul.length;	// 갯수 가져오기
		
		for(var i=0; i<clen; i++){
			
			if(document.myForm1.sul[i].checked==true){
				alert(document.myForm1.sul[i].value + "를 좋아하는구나");
				return;
			}
		}
		alert("술 안좋아함");
	}
	

</script>

</head>
<body>

좋아하는 술 종류<br/>
<form action="" name="myForm">
<a href="javascript:checkAll();">전체선택</a>
<a href="javascript:checkDel();">전체해제</a><br/>
<input type="checkbox" name="sul">진토닉<br/>
<input type="checkbox" name="sul">엑스<br/>
<input type="checkbox" name="sul">붐베이<br/>
<input type="checkbox" name="sul">앱솔<br/>
<input type="checkbox" name="sul">참이슬<br/>
<input type="checkbox" name="sul">테라<br/>
<input type="checkbox" name="sul">클라우드<br/>
<input type="checkbox" name="sul">뽜뽜뽀빠<br/>
</form>

<br/><br/><br/><br/><br/><br/>
가장 좋아하는 술 종류<br/>
<form action="" name="myForm1">
<input type="radio" name="sul" value="진토닉">진토닉<br/>
<input type="radio" name="sul" value="엑스">엑스<br/>
<input type="radio" name="sul" value="붐베이">붐베이<br/>
<input type="radio" name="sul" value="앱솔">앱솔<br/>
<input type="radio" name="sul" value="참이슬">참이슬<br/>
<input type="radio" name="sul" value="테라">테라<br/>
<input type="radio" name="sul" value="클라우드">클라우드<br/>
<input type="radio" name="sul" value="뽜뽜뽀빠">뽜뽜뽀빠<br/>
<a href="javascript:bestsul();">
<img src="./img/btn_poll01.gif"/>

</a>


</form>

</body>
</html>