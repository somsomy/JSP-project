<%@page import="board.QnABean"%>
<%@page import="board.QnADAO"%>
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
QnABean qb=qdao.getBoard(code);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd hh:mm");
%>
<article>
<h1>Q&A</h1>
<hr>
<form action="qnaUpdatePro.jsp" method="post">
<input type="hidden" name="code" value="<%=code%>">
<table id="cnotice">
<tr id="sub"><td >제목</td>
<td id="tsub"><input type="text" name="subject" id="title" placeholder="제목을 입력해주세요."  value="<%=qb.getSubject() %>" required></td></tr>
<tr><td class="tdtd">작성자</td>
<td class="tdtd"><%=qb.getName() %></td></tr>
<tr class="subsub"><td class="consub">내용</td>
<td class="consub"><textarea name="content" placeholder="내용을 입력해주세요." id="conupdate" required><%=qb.getContent() %></textarea></td></tr>
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