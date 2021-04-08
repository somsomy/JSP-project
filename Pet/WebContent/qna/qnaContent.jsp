<%@page import="board.QnABean"%>
<%@page import="board.QnADAO"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
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
<div id="text">Q&A</div>
<div id="sub_img_qna"></div>
<nav id="sub_menu">
</nav>
</div>
<div id="divArticle">
<%
int code=Integer.parseInt(request.getParameter("code"));
QnADAO qdao=new QnADAO();
qdao.updateReadcount(code);
QnABean qb=qdao.getBoard(code);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd hh:mm");
%>
<article>
<h1>Q&A</h1>
<hr>
<table id="cnotice">
<tr id="sub"><td colspan="2"><%=qb.getSubject() %></td></tr>
<tr><td colspan="2" id="write"> <%=qb.getName() %></td></tr>
<tr><td class="tdtd">작성일 <%=sdf.format(qb.getDate()) %></td></tr>
<tr><td colspan="2" id="con"><%=qb.getContent() %></td></tr>
</table>
<div id="wbtn">
<%
String id=(String)session.getAttribute("id");
MemberDAO mdao=new MemberDAO();
MemberBean mb=mdao.getMember(id);

if(id!=null) {
	if(id.equals("admin") && qb.getState().equals("답변대기")) {
		%>
<input type="button" value="답글달기" class="writeBtn" onclick="location.href='qnanswerForm.jsp?code=<%=qb.getCode() %>'">
		<%
	}
}

if(mb.getNick()!=null) {
if(mb.getNick().equals(qb.getName())) {
%>
<input type="button" value="글수정" class="writeBtn" onclick="location.href='qnaUpdateForm.jsp?code=<%=qb.getCode() %>'">
<input type="button" value="글삭제" class="writeBtn" onclick="location.href='qnaDelete.jsp?code=<%=qb.getCode()%>'">
<% } }%>
</div>
<%
if(id!=null) {
	if(id.equals("admin")) {
%>
<div id="wbtn">
<input type="button" value="글삭제" class="writeBtn" onclick="location.href='qnaDelete.jsp?code=<%=qb.getCode()%>'">
</div>
<%}} %>
<div class="clear"></div>

</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>