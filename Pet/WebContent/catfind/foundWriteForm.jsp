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

 <script defer src="../script/imageUpload.js"></script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>

<div class="clear"></div>
<div id="divSub">
<div id="text">찾았어요</div>
<jsp:include page="../inc/catfindSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">

<%
request.setCharacterEncoding("utf-8");

String id=(String)session.getAttribute("id");

MemberDAO mdao=new MemberDAO();
MemberBean mb=mdao.getMember(id);

%>
<script>
const id=<%=id%>
if(id==null) {
	alert("로그인이 필요합니다");
	location.href="../member/login.jsp";
}
</script>

<article>
<h1>찾았어요 글쓰기</h1>
<form action="foundWritePro.jsp" method="post" enctype="multipart/form-data" >
<table id="cnotice">
<tr id="sub"><td >제목</td><td id="tsub"><input type="text" name="subject" id="title" placeholder="제목을 입력해주세요." required></td></tr>
<tr><td class="tdtd">작성자</td><td class="tdtd"><input type="text" name="name" value="<%=mb.getNick() %>" id="writer" readonly></td></tr>
<tr class="subsub"><td class="consub">내용</td><td class="consub" id="previewId"><textarea name="content" placeholder="내용을 입력해주세요." id="conupdate" required></textarea></td></tr>
  <tr class="subimg"><td>이미지</td><td colspan="2">
  <label class="file">이미지등록
  <input type="file" name="file" id="file" onchange="previewImage(this,'previewId')"></label>
  </td></tr>
</table>
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