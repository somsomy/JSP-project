<%@page import="board.FoundBoardBean"%>
<%@page import="board.FoundBoardDAO"%>
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
<div id="text">찾았어요</div>
<hr id="texthr">
<div id="text2">따뜻한 가족의 품으로 돌아간 아이들</div>

<jsp:include page="../inc/catfindSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<%
int num=Integer.parseInt(request.getParameter("num"));

FoundBoardDAO fbdao=new FoundBoardDAO();
fbdao.updateReadcount(num);
FoundBoardBean fbb=fbdao.getBoard(num);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd hh:mm");
%>
<article>
<h1>찾았어요</h1>
<hr>
<table id="cnotice">
<tr id="sub"><td colspan="2"><%=fbb.getSubject() %></td></tr>
<tr><td colspan="2" id="write"><%=fbb.getName() %></td></tr>
<tr><td class="tdtd">  작성일 <%=sdf.format(fbb.getDate()) %></td><td id="readtd">조회수 <%=fbb.getReadcount() %></td></tr>
<tr id="cbtr"><td colspan="2" id="con">
<% if(fbb.getFile()!=null) { %>
<img src="../images/uploadImage/<%=fbb.getFile() %>" width="300" height="300"> 
<% } %>
</td></tr>
<tr><td colspan="2" id="con2"><%=fbb.getContent() %></td></tr>
</table>
<%
String id=(String)session.getAttribute("id");
MemberDAO mdao=new MemberDAO();
if(id != null) {
MemberBean mb=mdao.getMember(id);

if(mb.getNick()!=null) {
if(mb.getNick().equals(fbb.getName())) {
	
%>
<div id="wbtn">
<input type="button" value="글목록" class="writeBtn" onclick="location.href='catFound.jsp'">
<input type="button" value="글수정" class="writeBtn" onclick="location.href='foundUpdateForm.jsp?num=<%=fbb.getNum() %>'">
<input type="button" value="글삭제" class="writeBtn" onclick="location.href='foundDelete.jsp?num=<%=fbb.getNum()%>'">
</div>
<%
}
	}
}
if(id!=null) {
	if(id.equals("admin")) {
%>
<div id="wbtn">
<input type="button" value="글삭제" class="writeBtn" onclick="location.href='foundDelete.jsp?num=<%=fbb.getNum()%>'">
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