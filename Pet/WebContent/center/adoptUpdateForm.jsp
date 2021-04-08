<%@page import="cats.CatsBean"%>
<%@page import="cats.CatsDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
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
</div>>
<div id="divArticle">

<%
int num=Integer.parseInt(request.getParameter("num"));
BoardDAO bdao=new BoardDAO();
BoardBean bb=bdao.getBoard(num);
String ing="보호중";
CatsDAO cdao=new CatsDAO();
List<CatsBean> cbList=cdao.getProtectList(ing);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd hh:mm");
%>
<article>
<h1>입양 문의</h1>
<form action="adoptUpdatePro.jsp" method="post">
<input type="hidden" name="num" value="<%=bb.getNum()%>">
<table id="cnotice">
<tr id="sub"><td>글제목</td><td colspan="3" ><input type="text" name="subject" id="title" value="<%=bb.getSubject() %>" required></td></tr>
<tr class="tdtd"><td>작성자</td><td><input type="text" name="name" value="<%=bb.getName()%>" id="writer" placeholder="제목을 입력해주세요." readonly></td>
<td>고양이 이름</td><td>
<select name="catName" id="adwSelect">
	<%
	for(int i = 0; i<cbList.size(); i++) {
		CatsBean cb=cbList.get(i);
		%>
		<option <%if(bb.getCatName().equals(cb.getCatName())) {out.print("selected");} %>><%=cb.getCatName() %></option>
		<%
	}
	%>
</select>
</td>
</tr>
 <tr class="subsub"><td class="consub">글내용</td><td colspan="3" class="consub">
 <textarea name="content" placeholder="내용을 입력해주세요." id="conupdate" required><%=bb.getContent() %></textarea></td></tr>
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