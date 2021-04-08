<%@page import="cats.CatsDAO"%>
<%@page import="cats.CatsBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
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
request.setCharacterEncoding("utf-8");

String id=(String)session.getAttribute("id");
String ing="보호중";

MemberDAO mdao=new MemberDAO();

MemberBean mb=mdao.getMember(id);

CatsDAO cdao=new CatsDAO();
List<CatsBean> cbList=cdao.getProtectList(ing);

%>
<script>
const id=<%=id%>
if(id==null) {
	alert("로그인이 필요합니다");
	location.href="../member/login.jsp";
}
</script>
<article>
<h1>입양 문의 작성</h1>
<hr>
<form action="adoptWritePro.jsp" method="post">
<table id="cnotice">
<tr id="sub"><td>글제목</td><td colspan="3" ><input type="text" name="subject" id="title" placeholder="제목을 입력해주세요." required></td></tr>
<tr class="tdtd"><td>작성자</td><td><input type="text" name="name" value="<%=mb.getNick()%>" id="writer" readonly></td>
<td>고양이 이름</td><td>
<select name="catName" id="adwSelect">
	<%
	for(int i = 0; i<cbList.size(); i++) {
		CatsBean cb=cbList.get(i);
		%>
		<option><%=cb.getCatName() %></option>
		<%
	}
	%>
</select>
</td>
</tr>
 <tr class="subsub"><td class="consub">글내용</td><td colspan="3" class="consub">
 <textarea name="content" placeholder="내용을 입력해주세요." id="conupdate" required></textarea></td></tr>
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