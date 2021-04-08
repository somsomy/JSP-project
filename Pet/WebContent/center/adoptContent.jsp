<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
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
<hr id="texthr">
<div id="text2">아이들의 가족이 되어주세요.</div>
<jsp:include page="../inc/centerSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">

<%
int num=Integer.parseInt(request.getParameter("num"));
BoardDAO bdao=new BoardDAO();
bdao.updateReadcount(num);
BoardBean bb=bdao.getBoard(num);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd hh:mm");

%>
<article>
<h1>입양 문의</h1>
<hr>
<table id="cnotice">
<tr><td colspan="2" class="tdtd">고양이 <%=bb.getCatName() %> 입양 문의</td></tr>
<tr id="sub"><td colspan="2"><%=bb.getSubject() %></td></tr>
<tr><td colspan="2" id="write"><%=bb.getName() %></td></tr>
<tr><td class="tdtd"><%=sdf.format(bb.getDate()) %></td>
<td id="readtd">조회수 <%=bb.getReadcount() %></td></tr>
<tr id="cbtr"><td colspan="2" id="con"><%=bb.getContent() %></td></tr>
</table>
<%
String id=(String)session.getAttribute("id");
MemberDAO mdao=new MemberDAO();
if(id != null) {
MemberBean mb=mdao.getMember(id);

if(mb.getNick()!=null) {
if(mb.getNick().equals(bb.getName())) {
	
%>
<div id="wbtn">
<input type="button" value="글수정" class="writeBtn" onclick="location.href='adoptUpdateForm.jsp?num=<%=bb.getNum() %>'">
<input type="button" value="글삭제" class="writeBtn" onclick="location.href='adoptDelete.jsp?num=<%=bb.getNum()%>'">
</div>
<%
}
	}
}
if(id!=null) {
	if(id.equals("admin")) {
%>
<div id="wbtn">
<input type="button" value="글삭제" class="writeBtn" onclick="location.href='adoptDelete.jsp?num=<%=bb.getNum()%>'">
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