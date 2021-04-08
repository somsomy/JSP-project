<%@page import="cats.CatsBean"%>
<%@page import="cats.CatsDAO"%>
<%@page import="java.util.Date"%>
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
<link href="../css/adoptWrite.css" rel="stylesheet" type="text/css">

 <script defer src="../script/imageUpload.js"></script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">1:1후원</div>
<jsp:include page="../inc/supportSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<%
request.setCharacterEncoding("utf-8");

int catId = Integer.parseInt(request.getParameter("catId"));
CatsDAO cdao = new CatsDAO();
CatsBean cb=cdao.getCats(catId);
Date now = new Date();
String pattern ="yyyy-MM-dd";
SimpleDateFormat sdf = new SimpleDateFormat(pattern);
String today = sdf.format(now);
%>
<article>
<h1>후원 고양이</h1>
<input type="hidden" name="catId" value="<%=catId%>">
<table id="notice">
<tr id="atd"><td>고양이 이름</td><td><input type="text" name="catName" class="catName" value="<%=cb.getCatName()%>" readonly></td>
 <td>나이</td><td><input type="text" name="catAge" class="catAge" value="<%=cb.getCatAge()%>" readonly></td></tr>
<tr><td>성별</td><td><input type="text" name="catGender" value="<%=cb.getCatGender()%>" readonly></td>
 <td>중성화</td><td><input type="text" name="catNeuter" value="<%=cb.getCatNeuter()%>" readonly></td></tr>
<tr><td width="50">입소날짜</td><td><input type="text" name="catDate" value="<%=sdf.format(cb.getDate())%>" readonly></td>
 <td>접종유무</td><td><input type="text" name="catVaccination" value="<%=cb.getCatVaccination()%>" readonly></td></tr>
<tr id="abtd"><td>특이사항</td><td colspan="3">
 <img src="../images/uploadImage/<%=cb.getFileRealName()%>" width="300" height="300">
  <textarea name="catInfo" class="adoptContent" readonly><%=cb.getCatInfo() %></textarea></td></tr>
</table>
<div id="wbtn">
<input type="button" value="후원목록으로 돌아가기" class="writeBtn" onclick="location.href='supportCats.jsp'">
</div>
<div class="clear"></div>
</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>