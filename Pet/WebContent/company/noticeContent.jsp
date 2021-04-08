<%@page import="board.NoticeBean"%>
<%@page import="board.NoticeDAO"%>
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

</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">공지사항</div>
<hr id="texthr">
<div id="text2">고양이의 하루의 공지사항입니다.</div>
<jsp:include page="../inc/companySubMenu.jsp"></jsp:include>
</div>
<%
int num=Integer.parseInt(request.getParameter("num"));
NoticeDAO ndao=new NoticeDAO();
ndao.updateReadcount(num);
NoticeBean cb=ndao.getBoard(num);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd hh:mm");

String id=(String)session.getAttribute("id");

%>
<div id="divArticle">
<article>
<h1>공지사항</h1>
<hr>
<table id="cnotice">
<tr id="sub"><td colspan="2"><%=cb.getSubject() %></td></tr>
<tr><td colspan="2" id="write"><%=cb.getName() %></td></tr>
<tr><td class="tdtd">  작성일 <%=sdf.format(cb.getDate()) %></td><td id="readtd">조회수 <%=cb.getReadcount() %></td></tr>
<tr><td colspan="2" id="con"><%=cb.getContent() %></td></tr>
</table>

<div id="wbtn">
<input type="button" value="목록" class="writeBtn" onclick="location.href='notice.jsp'">
<%
if(id!=null) {
if(id.equals("admin")) { %>
<input type="button" value="수정" class="writeBtn" onclick="location.href='noticeUpdateForm.jsp?num=<%=cb.getNum() %>'">
<input type="button" value="삭제" class="writeBtn" onclick="location.href='noticeDelete.jsp?num=<%=cb.getNum()%>'">
<% } }%>
</div>
<div class="clear"></div>

</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>