<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
body{
	font-size: 11pt;
}
span.c1{
	color: blue;
}
.c2{
	color: red;
}
<!-- input에 사용할 css-->
input.box{
	border : 1px	solid#c8c8c8;
	width: 87px;
	height: 19px;
}
table {
	font-size: 10pt;
}

</style>
<!-- css파일을 불러옴 -->
<link rel="stylesheet" type="text/css" href="style.css"/>


</head>
<body>

기본 폰트 사이즈 11<br/>
외부 css파일 기본 폰트 사이즈 20

<!--  CSS ( Cascade Style Sheet) -->

<font size="1"> font 크기 1</font><br/>
<font size="2"> 폰트 크기 2</font><br/>
<font size="3"> 폰트 크기 3</font><br/>
<font size="4"> 폰트 크기 4</font><br/>
<font size="5"> 폰트 크기 5</font><br/>
<font size="6"> 폰트 크기 6</font><br/>
<font size="7"> 폰트 크기 7</font><br/>

<hr/>

<font style="font-size: 9pt;]"> font 크기 9</font><br/>
<font style="font-size: 12pt;]"> font 크기 12</font><br/>
<font style="font-size: 16pt;]"> font 크기 16</font><br/>
<font style="font-size: 20pt;]"> font 크기 20</font><br/>
<font style="font-size: 30pt;]"> font 크기 30</font><br/>
<font style="font-size: 60pt;]"> font 크기 60</font><br/>

<br/><br/><br/><br/>

<table border="1">
<tr align="center">
	<td width="300">
	<font color="blue">
2019년 12월 중국 우한에서 처음 발생한 이후 중국 전역과 전 세계로 확산된, 
새로운 유형의 코로나바이러스(SARS-CoV-2)에 의한 호흡기 감염질환이다. 
코로나바이러스감염증-19는 감염자의 비말(침방울)이 호흡기나 눈·코·입의 점막으로 침투될 때 전염된다.
	</font>
	</td>
	<td width="300">
	<font color="blue">
2019년 12월 중국 우한에서 처음 발생한 이후 중국 전역과 전 세계로 확산된, 
새로운 유형의 코로나바이러스(SARS-CoV-2)에 의한 호흡기 감염질환이다. 
코로나바이러스감염증-19는 감염자의 비말(침방울)이 호흡기나 눈·코·입의 점막으로 침투될 때 전염된다.
	</font>
	</td>
</tr>
</table>
<br/>
<table border="1" style="font-size: 2pt; color:blue;">
<tr align="center">
	<td width="300">
2019년 12월 중국 우한에서 처음 발생한 이후 중국 전역과 전 세계로 확산된, 
새로운 유형의 코로나바이러스(SARS-CoV-2)에 의한 호흡기 감염질환이다. 
코로나바이러스감염증-19는 감염자의 비말(침방울)이 호흡기나 눈·코·입의 점막으로 침투될 때 전염된다.
	</td>
	<td width="300">
2019년 12월 중국 우한에서 처음 발생한 이후 중국 전역과 전 세계로 확산된, 
새로운 유형의 코로나바이러스(SARS-CoV-2)에 의한 호흡기 감염질환이다. 
코로나바이러스감염증-19는 감염자의 비말(침방울)이 호흡기나 눈·코·입의 점막으로 침투될 때 전염된다.
	</td>
</tr>
</table>

<br/><br/><br/><br/><br/>

<span style="color:blue;">코로나</span>
2019년 12월 중국 우한에서 처음 발생한 이후 중국 전역과 전 세계로 확산된, 
새로운 유형의 <span style="color:blue;">코로나</span>바이러스(SARS-CoV-2)에 의한 호흡기 감염질환이다. 
<span style="color:blue;">코로나</span>바이러스감염증-19는 <span style="color:red;">감염자의 비말(침방울)</span>이 호흡기나 눈·코·입의 점막으로 침투될 때 전염된다.

<br/><br/><br/><br/><br/>

<span class="c2">코로나</span>
2019년 12월 중국 우한에서 처음 발생한 이후 중국 전역과 전 세계로 확산된, 
새로운 유형의 <span class="c2">코로나</span>바이러스(SARS-CoV-2)에 의한 호흡기 감염질환이다. 
<span class="c2">코로나</span>바이러스감염증-19는 <span class="c1">감염자의 비말(침방울)</span>이 호흡기나 눈·코·입의 점막으로 침투될 때 전염된다.

<br/><br/><br/><br/><br/><br/>

<!--  파일로 만든 css로 변경 -->
<span class="c3">코로나</span>
2019년 12월 중국 우한에서 처음 발생한 이후 중국 전역과 전 세계로 확산된, 
새로운 유형의 <span class="c3">코로나</span>바이러스(SARS-CoV-2)에 의한 호흡기 감염질환이다. 
<span class="c3">코로나</span>바이러스감염증-19는 <span class="c4">감염자의 비말(침방울)</span>이 호흡기나 눈·코·입의 점막으로 침투될 때 전염된다.

<br/><br/><br/><br/><br/><br/>

<table style="font-size: 10pt; font-style: 돋움; "cellpadding="3">
<tr>
	<!-- 
	 box css에 아이디라는 그림을 가져다 넣음.
	no-repeat = 반복하지않음. id가 한개만 나옴
	onfocus = 커서를 가져다대면 null로 바뀜
	-->
	
	<td><input type="text" class="box" style="background:url('./img/bg_log_id.gif') no-repeat 5px 3px #ffffff;"
	onfocus="this.style.backgroundImage='';"></td>
	<td></td>
</tr>
<tr>
	<td><input type="password" class="box" style="background:url('./img/bg_log_pw.gif') no-repeat 5px 3px #ffffff;"
	onfocus="this.style.backgroundImage='';"></td>
	<td><img src="./img/btn_login.gif"></td>
</tr>
<tr>
	<td colspan="3" align="center">
	<input type="checkbox">아이디 저장
	<input type="checkbox" checked="checked"> 보안 접속
	</td>
</tr>

<tr height="1">
	<td colspan="3" bgcolor="#dad6d7"></td>
</tr>

</table>





</body>
</html>