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
<link href="../css/content.css" rel="stylesheet" type="text/css">

 <script defer src="../script/imageUpload.js"></script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">입양완료</div>
<hr id="texthr">
<div id="text2">새로운 가족을 맞이한 아이들.</div>
<jsp:include page="../inc/centerSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">

<%
request.setCharacterEncoding("utf-8");

int catId = Integer.parseInt(request.getParameter("catId"));
CatsDAO cdao = new CatsDAO();
cdao.updateReadcount(catId);
CatsBean cb=cdao.getCats(catId);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<article>
<h1>입양 완료</h1>
<hr>
<input type="hidden" name="catId" value="<%=catId%>">
<table id="cnotice">
<tr id="sub"><td colspan="2" >저는 고양이 '<span><%=cb.getCatName()%></span>' 입니다.</td></tr>
<tr><td class="td"><span><%=cb.getCatGender() %></span> 이구요.</td><td id="readtd">중성화 <%=cb.getCatNeuter() %></td></tr>
<tr><td class="td">나이는 <span><%=cb.getCatAge() %></span> 입니다.</td><td id="readtd">접종 <%=cb.getCatVaccination() %></td></tr>
<tr><td class="td">이곳에는 <span><%=cb.getCatDate() %></span> 에 왔어요!</td><td id="readtd">조회수 <%=cb.getReadcount() %></td></tr>
<tr><td id="con" colspan="2" ><img src="../images/uploadImage/<%=cb.getFileRealName()%>" id="conimg"></td></tr>
<tr><td colspan="2" id="con3"><%=cb.getCatInfo() %></td></tr>
</table>
<div id="wbtn">
<input type="button" value="목록으로 돌아가기" class="writeBtn" onclick="location.href='catsAdoptComp.jsp'" >
</div>
<div class="clear"></div>

</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>