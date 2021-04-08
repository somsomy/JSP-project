<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">로그인</div>
<div id="sub_img_member1"></div>
<nav id="sub_menu">
</nav>
</div>
<div id="divArticle">
<article>
<h1>로그인</h1>
<hr>
<form action="loginPro.jsp" id="join" method="post">
<fieldset>
<div id="box">
<label>아이디</label>
<input type="text" name="id" class="loginPage"><br>
<label>비밀번호</label>
<input type="password" name="pass" class="loginPage"><br>
<div id="buttons">
<input type="submit" value="로그인" class="submit">
</div>
</div>
</fieldset>
<div class="clear"></div>
</form>
</article>
</div>

<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>