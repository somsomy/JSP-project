<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/dubcheck.jsp</title>
<link href="../css/dup.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function ok1() {
	window.opener.document.fr.nick.value=document.wfr.nick.value;
	window.opener.document.getElementById('nickCheck').style.color='green';
	window.opener.document.getElementById('nickCheck').innerHTML='닉네임 사용 가능합니다.';
	window.close();
}
</script>
<script defer src="../script/nickCheck.js"></script>
<script>
var ckck5 = function() {
	document.getElementById('idOk').style.display='none';
}

var ckck6 = function() {
	document.getElementById('idNo').style.display='none';
}

var ckhide1 = function()  {
	document.getElementById('dupck').style.display='none';

}
</script>
</head>
<body>
<img src="../images/dup.png">
<h4>고양이의 하루</h4>
<h2>닉네임 중복 확인</h2>
<%
String nick=request.getParameter("nick");
MemberDAO mdao=new MemberDAO();
%>
<form action="nickDupCheck.jsp" method="get" name="wfr">
<div>입력한 닉네임</div>
<div id="id_container">
<input type="text" name="nick" value="<%=nick%>" id="nick" maxlength="20" onkeyup="check4();ckck5();" onkeydown="ckck6();">
<input type="submit" value="중복확인" id="dupck" class="btn" onclick="ckhide1()"> 
</div>
<span id="nickCheck"></span>
<%
int check=mdao.nickDupCheck(nick);
int check2=mdao.nickCheck(nick);
if(check==-1&&check2>=1) {
	%>
	<div id="idOk" >닉네임 사용 가능합니다.<input type="button" value="닉네임 사용" class="btn" onclick="ok1()"></div>
	<%
} else {
	%>
	<div id="idNo">닉네임 사용 불가능합니다. 다시 입력해주세요.</div>
	<%
}
%>
</form>
</body>
</html>