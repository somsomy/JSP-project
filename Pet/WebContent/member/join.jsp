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

<script defer src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script defer src="../script/postcode.js"></script>
<script defer src="../script/passpass.js"></script>
<script defer src="../script/passcheck.js"></script>
<script defer src="../script/idcheck.js"></script>
<script defer src="../script/selectbox.js"></script>
<script defer src="../script/nickCheck.js"></script>
 <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
  <script type="text/javascript">
 function idDupCheck() {
	if(document.fr.id.value=="") {
		document.getElementById('idCheck').style.color='red';
		document.getElementById('idCheck').textContent='아이디를 입력하세요.';
		document.fr.id.focus();
		return;
	}
	
	var idvalue=document.fr.id.value;
	window.open("idDupCheck.jsp?id="+idvalue,"아이디 중복 확인","width=400,height=300");
}
 
 function nickDupCheck() {
		if(document.fr.nick.value=="") {
			document.getElementById('nickCheck').style.color='red';
			document.getElementById('nickCheck').textContent='닉네임 입력하세요.';
			document.fr.nick.focus();
			return;
		}
		
		var nickvalue=document.fr.nick.value;
		window.open("nickDupCheck.jsp?nick="+nickvalue,"닉네임 중복 확인","width=400,height=300");
	}
 </script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">회원가입</div>
<div id="sub_img_member"></div>
</div>
<article id="joinArticle">
<h1>회원가입</h1>
<hr>
<form action="joinPro.jsp" name="fr" id="join" method="post" >
<fieldset>
<h3>아이디 <img src="../images/dry-clean.png" class="dot"></h3>
<input type="text" name="id" class="id"  id="id" maxlength="20" onkeyup="check3();" required>
<input type="button" value="중복확인" class="dup" onclick="idDupCheck()"><br>
<span id="idCheck"></span>
<h3>비밀번호 <img src="../images/dry-clean.png" class="dot"></h3>
<input type="password" name="pass" id="pass" maxlength="16"
placeholder="영문 대소문자, 숫자, 특수문자(!,@,#) 중 2가지 이상 포함한 8~16자리" 
onkeyup='check();check2();' required/><br>
<span id="passCheck"></span>
<h3>비밀번호 확인 <img src="../images/dry-clean.png" class="dot"></h3>
<input type="password" name="confirmPassword" id="confirmPassword" 
onkeyup='check();' maxlength="16"
required /><br>
<span id="message"></span>
<h3>성함 <img src="../images/dry-clean.png" class="dot"></h3>
<input type="text" name="name" maxlength="10" required>
<h3>닉네임 <img src="../images/dry-clean.png" class="dot"></h3>
<input type="text" name="nick" maxlength="10" class="id" id="nick" onkeyup="check4();" required>
<input type="button" value="중복확인" class="dup" onclick="nickDupCheck()"><br>
<span id="nickCheck"></span>
<h3>이메일 <img src="../images/dry-clean.png" class="dot"></h3>
<input type="text" name="emailId" class="emailId" id="emailId" required>@
<input type="text" name="email" class="email" id="email" required>
<select name="customSelect" id="customSelect" onchange="setSelect();">
 <option>직접입력</option>
  <option>naver.com</option>
  <option>gmail.com</option>
</select> <br>
<h3>휴대전화 <img src="../images/dry-clean.png" class="dot"></h3>
<input type="text" name="phone1" class="phone" maxlength="4" required> -
<input type="text" name="phone2" class="phone" maxlength="4" required> -
<input type="text" name="phone3" class="phone" maxlength="4" required>
</fieldset>

<fieldset>
<h3>우편번호</h3>
<input type="text" name="postCode" class="postCode" id="postCode" readonly>
<input type="button" value="우편번호 검색" class="dup" onclick="execDaumPostcode()"><br>
<h3>주소</h3>
<input type="text" name="address" id="address" placeholder="주소"><br>
<h3>상세주소</h3>
<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" >
<div id="buttons">
<input type="submit" value="회원가입" class="submit">
</div>
</fieldset>
<div class="clear"></div>
</form>
</article>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>