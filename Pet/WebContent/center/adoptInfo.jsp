<%@page import="java.text.SimpleDateFormat"%>
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
<div id="text">입양안내</div>
<hr id="texthr">
<div id="text2">입양 전 확인해야 할 사항입니다.</div>
<jsp:include page="../inc/centerSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">

<div class="clear"></div>
<article>
<div id="adtInfo">
<img src="../images/center/adopt_info.png" width="700" >
</div>
</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>