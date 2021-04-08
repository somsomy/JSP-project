<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/myPage.css" rel="stylesheet" type="text/css">

<script defer src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script defer src="../script/mypostcode.js"></script>
<script defer src="../script/nickCheck.js"></script>

<script>
function nickDupCheck() {
	if(document.fr.nick.value=="") {
		document.getElementById('nickCheck').style.color='red';
		document.getElementById('nickCheck').textContent='닉네임 입력하세요.';
		document.fr.nick.focus();
		return;
	}
	
	var nickvalue=document.fr.nick.value;
	window.open("nickDupCheck.jsp?nick="+nickvalue,"닉네임 중복 확인","width=420,height=300");
}

</script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">마이페이지</div>
<hr id="texthr">
<div id="text2">회원정보</div>
<jsp:include page="../inc/myPageSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<article>
<%
String id=(String)session.getAttribute("id");

MemberDAO mdao=new MemberDAO();

MemberBean mb=mdao.getMember(id);
%>
<h1>나의 정보</h1>
<hr>
<form action="updatePro.jsp"  id="join" method="post" name="fr">
<div id="myinfo">
<fieldset>
<h3>아이디 <img src="../images/dry-clean.png" class="dot"></h3>
<input type="text" name="id" class="myPageid"  maxlength="20" value="<%=mb.getId() %>" readonly>
<h3>이름 <img src="../images/dry-clean.png" class="dot"></h3>
<input type="text" name="name" maxlength="10"
placeholder="10자리 이하 사용 가능" value="<%=mb.getName() %>" required><br>
<h3>닉네임 <img src="../images/dry-clean.png" class="dot"></h3>
<input type="text" name="nick" id="nick" value="<%=mb.getNick()%>" onkeyup="check4();" required>
<input type="button" value="중복확인" class="dup" onclick="nickDupCheck()"><br>
<span id="nickCheck"></span>
<h3>이메일 <img src="../images/dry-clean.png" class="dot"></h3>
<input type="email" name="email" id="myPageEmail" value="<%=mb.getEmail()%>" required>
<h3>휴대전화</h3>
<input type="text" name="phone" id="myPagePhone" value="<%=mb.getPhone()%>" maxlength="16" required>
<br>
</fieldset>

<fieldset>
<h3>우편번호</h3>
<input type="text" name="postCode" class="postCode" id="postCode" value="<%=mb.getPostCode()%>" readonly>
<input type="button" value="우편번호 검색" class="dup" onclick="execDaumPostcode()"><br>
<h3>주소</h3>
<input type="text" name="address" id="address" placeholder="주소" value="<% out.print(mb.getAddress().equals("null")? "" : mb.getAddress()); %>"><br>
<h3>상세주소</h3>
<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" value="<%=mb.getDetailAddress() %>">
<h3>비밀번호</h3>
<input type="password" name="pass" id="pass" maxlength="16"
onkeyup='check();' required/><br>
</fieldset>
</div>
<div class="clear"></div>
<div id="buttons1">
<input type="submit" value="회원정보수정" class="submit">
<input type="reset" value="취소" class="cancel">
</div>
</form>
</article>
</div>

<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>