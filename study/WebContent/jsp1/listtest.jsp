<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	// 왼쪽 아이템창에 추가하는 것
	function itemAdd(){
		
		 f = document.myForm;
		
		// leftItem에 f의 leftItem을 넣어서 앞의 f. 를 지울 수 있다
		var leftItem = f.leftItem;
		
		// 왼쪽 아이템 0번째, 앞은 보이는 값, 뒤는 value값
		leftItem[0] = new Option('다스리','다스리');
		leftItem[1] = new Option('즐리','즐리');
		leftItem[2] = new Option('차도르','차도르');
		leftItem[3] = new Option('빙시','빙시');
		leftItem[4] = new Option('루뱃','루뱃');
		leftItem[5] = new Option('동재','동재');
		leftItem[6] = new Option('붕붕이','붕붕이');
/*
		// 왼쪽 아이템 0번째, 앞은 보이는 값, 뒤는 value값
		f.leftItem[0] = new Option('다스리','다스리');
		f.leftItem[1] = new Option('즐리','즐리');
		f.leftItem[2] = new Option('차도르','차도르');
		f.leftItem[3] = new Option('빙시','빙시');
		f.leftItem[4] = new Option('루뱃','루뱃');
		f.leftItem[5] = new Option('동재','동재');
		f.leftItem[6] = new Option('붕붕이','붕붕이');
*/	}
	
	// 아이템을 버튼을 눌르면 옮기는 것
	function itemMove(value){
		
		var f = document.myForm;
		var source, target;
		
		// left라는 값이 들어오면 오른쪽의 아이템을 왼쪽으로 보냄 (소스:rightItem, 타겟:leftItem)
		if(value=="left"){
			source = f.rightItem;
			target = f.leftItem;
		}
		else{
			source = f.leftItem;
			target = f.rightItem;
		}
		
		var n, i;
		// 보내는 데이터를 마지막에 넣기위해 길이 변수를 저장  
		n = target.length;
		
		// 끝에서부터 역순으로 반복
		for(i=source.length-1; i>=0; i--){
			// i번째가 선택되어있으면 실행
			if(source.options[i].selected){
				target[n++] = new Option(source.options[i].text, source.options[i].value);
				source[i] = null;
			}
		}
		
	}
	
	// 메세지를 보내는 함수
	function sendIt(){
		
		var f = document.myForm;
		if(f.rightItem.length==0){
			alert("쪽지를 보낼 사람을 선택하세요.");
			f.rightItem.focus();
			return;
		}
		if(!f.msg.value){
			alert("메세지를 입력해주세요");
			f.msg.focus();
			return;
		}
		alert("뿅");
		// 받는 사람 자동 선택
		for(var i=0;i<f.rightItem.length; i++){
			f.rightItem[i].selected = true;
			// f.rightItem.options[i].selected = true;
		}
	
		f.submit();
	}
	


</script>

<!--  스타일. css -->
<style type="text/css">

body {
	font-size: 9pt;
}
.itemBtn{
	font-size: 9pt;
	color: rgb(0,0,0);
	background-color: rgb(137,207,240);
	width: 30pt;
}

.btn{
	font-size: 9pt;
	color: rgb(0,0,0);
	background-color: rgb(137,207,240);
	width: 100pt;
}

.itemList{
	fon-size: 9pt;
	width: 100pt;
}

</style>


</head>
<!-- itemAdd 객체를 넣고 시작함 onload -->
<body onload="itemAdd();">

<!--
  css가 .으로 시작하는 것은 class로 선언
  
-->

<form action="listtest_ok.jsp" method="post" name="myForm">
<table border="0" style="font-size:9pt">
	<tr>
		<td width="150"> 전체 리스트 </td>
		<td width="70">&nbsp;</td>
		<td width="150">받는사람</td>
	</tr>
<tr align="center">
	<td width="150">
		<select name="leftItem" multiple="multiple" size="7" class="itemList">
		</select>
	</td>
	<td width=70>
		<input type="button" value="&gt;" class="itemBtn" onclick="itemMove('right')"><br/>
		<input type="button" value="&lt;" class="itemBtn" onclick="itemMove('left')"><br/>
	</td>
	<td width="150">
		<select name="rightItem" multiple="multiple" size="7" class="itemList">
		</select>
	</td>
</tr>
<tr>
	<td colspan="3">
	<br/>메세지<br/>
	<textarea rows="5" cols="42" name="msg"></textarea>
	</td>
</tr>

<tr>
	<td colspan="3" align="center">
		<input type="button" value="쪽지보내기" class="btn" onclick="sendIt();"/><br/>
	</td>
</tr>
</table>


</form>

</body>
</html>