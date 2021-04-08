<%@page import="cats.CatsBean"%>
<%@page import="cats.CatsDAO"%>
<%@page import="java.util.Date"%>
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
<link href="../css/findUpdate.css" rel="stylesheet" type="text/css">

 <script defer src="../script/imageUpload.js"></script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">관리자 고양이 등록</div>
<hr id="texthr">
<div id="text2">고양이 등록 / 취소 관리</div>
<jsp:include page="../inc/myPageSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<%
request.setCharacterEncoding("utf-8");

String id=(String)session.getAttribute("id");
MemberDAO mdao=new MemberDAO();
MemberBean mb=mdao.getMember(id);

int catId = Integer.parseInt(request.getParameter("catId"));
CatsDAO cdao = new CatsDAO();
CatsBean cb=cdao.getCats(catId);

Date now = new Date();
String pattern ="yyyy-MM-dd";
SimpleDateFormat sdf = new SimpleDateFormat(pattern);
String today = sdf.format(now);
%>
<article>
<h1>고양이 목록</h1>
<table id="catUpdateTab">
<tr><td class="sub"><label for="subject">고양이이름</label></td><td colspan="3" class="sub"><input type="text" name="catName" value="<%=cb.getCatName() %>" class="ttd" id="subject"></td></tr>
<tr><td colspan="4" id="writer">작성자 <%=mb.getNick() %></td></tr>
<tr><td class="line" id="ph">나이</td><td class="line"><%=cb.getCatAge() %></td>
<td class="line" id="do">보호중/입양완료</td>
<td class="line">
<%=cb.getCatIng() %>
</td>
</tr>
<tr><td class="subsub">성별</td><td>
<%=cb.getCatGender() %></td>
<td class="subsub">중성화</td><td>
<%=cb.getCatNeuter() %>
</tr>
<tr><td class="subsub">입소날짜</td><td>
<input type="date" name="catDate" max="<%=today%>" value="<%=cb.getCatDate()%>" readonly>
</td>
<td class="subsub">접종유무</td><td>
<%=cb.getCatVaccination() %>
</td></tr>
<tr><td class="subsub">이미지</td><td colspan="3"><img src="../images/uploadImage/<%=cb.getFileRealName()%>" width="300" height="300"></td></tr>
<tr><td class="subsub">특이사항</td><td colspan="3" id="previewId"><textarea name="catInfo" placeholder="내용을 입력해주세요."><%=cb.getCatInfo() %></textarea></td></tr>
</table>
<div id="wbtn">
<input type="button" value="수정하기" class="writeBtn" onclick="location.href='catRegUpdateForm.jsp?catId=<%=catId%>'" >
<input type="button" value="삭제하기" class="writeBtn" onclick="location.href='catRegDelete.jsp?catId=<%=catId%>'">
</div>
<div class="clear"></div>

</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>