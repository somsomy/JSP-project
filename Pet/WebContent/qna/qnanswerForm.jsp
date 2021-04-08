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
<div id="sub_img"></div>
<div id="divArticle">
<nav id="sub_menu">
</nav>

<%
request.setCharacterEncoding("utf-8");

String id=(String)session.getAttribute("id");

MemberDAO mdao=new MemberDAO();

MemberBean mb=mdao.getMember(id);

int code=Integer.parseInt(request.getParameter("code"));

QnADAO qdao=new QnADAO();
QnABean qb=qdao.getBoard(code);

%>
<script>
const id=<%=id%>
if(id==null) {
	alert("로그인이 필요합니다");
	location.href="../member/login.jsp";
}
</script>
<article>
<h1>Q&A 답변 작성</h1>
<form action="qnanswerPro.jsp" method="post">
<input type="hidden" name="originNum" value="<%=qb.getNum()%>">
<input type="hidden" name="code" value="<%=qb.getCode()%>">
<table id="cnotice">
<tr id="sub"><td>글제목</td><td colspan="3"><input type="text" name="subject" value="답변입니다." id="title" readonly></td></tr>
<tr id="atd"><td>작성자</td><td class="tdtd"><input type="text" name="name" value="<%=mb.getName()%>" id="writer" readonly></td></tr>
 <tr class="subsub"><td class="consub">글내용</td><td colspan="3" class="consub"><textarea name="content" placeholder="내용을 입력해주세요." id="conupdate" required></textarea></td></tr>
</table>
<div class="clear"></div>
<div id="wbtn">
<input type="submit" value="글쓰기" class="writeBtn" >
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