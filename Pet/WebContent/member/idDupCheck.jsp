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
function ok() {
	window.opener.document.fr.id.value=document.wfr.id.value;
	window.opener.document.getElementById('idCheck').style.color='green';
	window.opener.document.getElementById('idCheck').innerHTML='아이디 사용 가능합니다.';
	window.close();
}
</script>
<script defer src="../script/idcheck.js"></script>
<script>
var ckck = function() {
	document.getElementById('idOk').style.display='none';
}

var ckck2 = function() {
	document.getElementById('idNo').style.display='none';
}

var ckhide = function()  {
	document.getElementById('dupck').style.display='none';

}
</script>
</head>
<body>
<img src="../images/dup.png">
<h4>고양이의 하루</h4>
<h2>아이디 중복 확인</h2>
<%
String id=request.getParameter("id");
MemberDAO mdao=new MemberDAO();
%>
<form action="idDupCheck.jsp" method="get" name="wfr">
<div>입력한 아이디</div>
<div id="id_container">
<input type="text" name="id" value="<%=id%>" id="id" maxlength="20" onkeyup="check3();ckck();" onkeydown="ckck2();">
<input type="submit" value="중복확인" id="dupck" class="btn" onclick="ckhide()"> 
</div>
<span id="idCheck"></span>
<%
int check=mdao.idDupCheck(id);
int check2=mdao.idCheck(id);
if(check==-1&&check2>=2) {
	%>
	<div id="idOk" >아이디 사용 가능합니다.<input type="button" value="아이디 사용" class="btn" onclick="ok()"></div>
	<%
} else {
	%>
	<div id="idNo">아이디 사용 불가능합니다. 다시 입력해주세요.</div>
	<%
}
%>
</form>
</body>
</html>