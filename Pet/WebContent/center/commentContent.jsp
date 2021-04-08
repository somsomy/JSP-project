<%@page import="board.ComBoardBean"%>
<%@page import="board.ComBoardDAO"%>
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
<div id="text">입양후기</div>
<hr id="texthr">
<div id="text2">가족을 만나 행복한 하루를 보내는 아이들.</div>
<jsp:include page="../inc/centerSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">

<%
int num=Integer.parseInt(request.getParameter("num"));

ComBoardDAO cbdao=new ComBoardDAO();
cbdao.updateReadcount(num);
ComBoardBean cbb=cbdao.getBoard(num);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd hh:mm");

%>
<article>
<h1>입양 후기</h1>
<form action="adoptWritePro.jsp" method="post">
<table id="cnotice">
<tr id="sub"><td colspan="2"><%=cbb.getSubject() %></td></tr>
<tr><td colspan="2" id="write"><%=cbb.getName() %></td></tr>
<tr><td class="tdtdtd">  작성일 <%=sdf.format(cbb.getDate()) %></td><td id="readtdtd">조회수 <%=cbb.getReadcount() %></td></tr>
<%if(cbb.getFileRealName()!=null) {%>
<tr><td colspan="2" id="con2"><img src="../images/uploadImage/<%=cbb.getFileRealName()%>" id=conimg></td></tr>
<% } %>
<tr><td colspan="2" id="con3"><%=cbb.getContent() %></td></tr>
</table>
</form>
<%
String id=(String)session.getAttribute("id");
MemberDAO mdao=new MemberDAO();
if(id != null) {
MemberBean mb=mdao.getMember(id);

if(mb.getNick()!=null) {
if(mb.getNick().equals(cbb.getName())) {
	
%>
<div id="wbtn">
<input type="button" value="글목록" class="writeBtn" onclick="location.href='comment.jsp'">
<input type="button" value="글수정" class="writeBtn" onclick="location.href='commentUpdateForm.jsp?num=<%=cbb.getNum() %>'">
<input type="button" value="글삭제" class="writeBtn" onclick="location.href='commentDelete.jsp?num=<%=cbb.getNum()%>'">
</div>
<%
}
	}
}
if(id!=null) {
	if(id.equals("admin")) {
%>
<div id="wbtn">
<input type="button" value="글삭제" class="writeBtn" onclick="location.href='commentDelete.jsp?num=<%=cbb.getNum()%>'">
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