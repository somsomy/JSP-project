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
<div id="divArticle">

<%
int num=Integer.parseInt(request.getParameter("num"));
NoticeDAO ndao=new NoticeDAO();
NoticeBean nb=ndao.getBoard(num);
SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd hh:mm");
%>
<article>
<h1>공지사항 수정</h1>
<hr>
<form action="noticeUpdatePro.jsp" method="post">
<input type="hidden" name="num" value="<%=num%>">
<table id="cnotice">
<tr id="sub"><td >제목</td><td id="tsub"><input type="text" name="subject" id="title" placeholder="제목을 입력해주세요."  value="<%=nb.getSubject() %>" required></td></tr>
<tr><td class="tdtd">작성자</td><td  class="tdtd"><%=nb.getName() %></td></tr>
<tr class="subsub"><td class="consub">내용</td><td class="consub"><textarea name="content" placeholder="내용을 입력해주세요." id="conupdate" required><%=nb.getContent() %></textarea></td></tr>
</table>
<div id="wbtn">
<input type="submit" value="글수정" class="writeBtn" >
</div>
</form>

<div class="clear"></div>

</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>