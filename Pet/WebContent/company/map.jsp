<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/map.css" rel="stylesheet" type="text/css">

 <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b912d2e51405cf5bb1df8bfaa345a2f0"></script>
 <script defer src="../script/map.js"></script>
 
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">센터 위치</div>
<hr id="texthr">
<div id="text2">고양이의 하루는 여러분 가까이에 있습니다.</div>
<jsp:include page="../inc/companySubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<article>
<h1>센터 위치</h1>
<hr>
<div id="mapLine">
<div id="map" >지도</div>
</div>
</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>



    